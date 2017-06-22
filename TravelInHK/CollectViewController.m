//
//  CollectViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "CollectViewController.h"
#import "Ceshi3ViewController.h"
#import "Ceshi4ViewController.h"
#import "Ceshi5ViewController.h"
#import "HotelTableViewController.h"
#import "RelaxTableViewController.h"
#import "FMDatabase.h"
#import "CItem.h"
@interface CollectViewController ()

@end

@implementation CollectViewController
@synthesize path;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"favorite_icon_on"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorite_icon"]];
    }
    return self;
}
-(void)viewDidDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=NO;
}
-(void)viewDidAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=YES;
    
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
  
    dataArray=[[NSMutableArray alloc]init];
    
    arrayItem=[[NSMutableArray alloc]init];
    jingdian=[[NSMutableArray alloc]init];
    zhusu=[[NSMutableArray alloc]init];
    meishi=[[NSMutableArray alloc]init];
    gouwu=[[NSMutableArray alloc]init];
    yule=[[NSMutableArray alloc]init];
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"news.db"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        
    }
    NSMutableString *str1=[[NSMutableString alloc]init];
    
    NSMutableString *str11=[[NSMutableString alloc]init];
    
    FMResultSet *set=[db executeQuery:@"select * from FVRT"];
    
    while ([set next]) {
        str1=[set objectForColumnName:@"title"];
        
        str11=[set objectForColumnName:@"id"];
        
        CItem *item=[[CItem alloc]init];
        item.title=str1;
        
        item.idNum=[str11 integerValue];
        [arrayItem addObject:item];
        
    }
    [db close];
   
    
    [self creatArray];
    
    arrayZong=[[NSMutableArray alloc]init];
    arrayBaokuo=[[NSMutableArray alloc]init];
    
    [arrayZong addObjectsFromArray:jingdian];
    [arrayZong addObjectsFromArray:zhusu];
    [arrayZong addObjectsFromArray:meishi];
    [arrayZong addObjectsFromArray:gouwu];
    [arrayZong addObjectsFromArray:yule];
    arrayBaokuo=[[NSMutableArray alloc]initWithObjects:arrayZong,jingdian,zhusu,meishi,gouwu,yule,nil];
    [dataArray addObjectsFromArray:arrayZong];
    
    smile=[[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 460-44-40-49)];
    UIImageView *mi=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Ok_smile"]];
    mi.frame=CGRectMake(130, 120, 65, 58);
    smile.backgroundColor=[UIColor whiteColor];
    [smile addSubview:mi];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 120+58+10, 320, 20)];
    label.text=@"你还没有收藏任何东东";
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    [smile addSubview:label];
    
    [self.view addSubview:smile];
    
    
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320, 460-44-49-40) style:UITableViewStylePlain];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    if([dataArray count]==0){
      
        smile.hidden=NO;
        [self.view bringSubviewToFront:smile];
        
    }else{
        
        smile.hidden=YES;
    }
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"收藏";
    
    NSArray *array=[NSArray arrayWithObjects:@"全部",@"景点",@"住宿",@"美食",@"购物",@"娱乐",nil];
    
    for(int i=0;i<[array count];i++){
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(i*53, 0, 53.333333333, 40)];
        img.image=[UIImage imageNamed:@"fav_lei_nor"];
        img.userInteractionEnabled=YES;
        img.tag=100+i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(next:)];
        [img addGestureRecognizer:tap];
        
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 53.333, 40)];
        label.text=[array objectAtIndex:i];
        label.textAlignment=NSTextAlignmentCenter;
        label.backgroundColor=[UIColor clearColor];
        [img addSubview:label];
        [self.view addSubview:img];
    }
    
    }
-(void)creatArray{
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
    }
    
    for(int i=0;i<[arrayItem count];i++){
        CItem *item=[arrayItem objectAtIndex:i];
        if([item.title isEqualToString:@"listdo_scenic_main"]==1){
        FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_scenic_main where scenicid='%d'",item.idNum]];
            
            while ([set next]) {
                CItem *ci=[[CItem alloc]init];
                ci.name=[set objectForColumnName:@"scenicname"];
                ci.score=[[set objectForColumnName:@"score"]floatValue];
                ci.address=[set objectForColumnName:@"address"];
                ci.img=@"bg_s_s1";
                ci.type=@"listdo_scenic_main";
                 ci.idNum=[[set objectForColumnName:@"scenicid"]integerValue];
                [jingdian addObject:ci];
               
            }
        }
                         
        else if ([item.title isEqualToString:@"listdo_shopping_main"]==1){
            FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_shopping_main where scenicid='%d'",item.idNum]];
            
            while ([set next]) {
                CItem *ci=[[CItem alloc]init];
                ci.name=[set objectForColumnName:@"scenicname"];
                ci.score=[[set objectForColumnName:@"score"]floatValue];
                ci.address=[set objectForColumnName:@"address"];
                ci.img=@"bg_sh_s1";
                ci.idNum=[[set objectForColumnName:@"scenicid"]integerValue];

                ci.type=@"listdo_shopping_main";
                [gouwu addObject:ci];
                
            }
        }
        else if ([item.title isEqualToString:@"listdo_food_restaurant"]==1){
            FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_food_restaurant where restaurent_id='%d'",item.idNum]];
            
            while ([set next]) {
                CItem *ci=[[CItem alloc]init];
                ci.name=[set objectForColumnName:@"restaurent_name"];
                ci.score=[[set objectForColumnName:@"score"]floatValue];
                ci.address=[set objectForColumnName:@"restaurent_address"];
                ci.img=@"bg_e_s1";
                ci.idNum=[[set objectForColumnName:@"restaurent_id"]integerValue];

                ci.type=@"listdo_food_restaurant";
                [meishi addObject:ci];
                
            }
        }
        else if ([item.title isEqualToString:@"listdo_hotel_main"]==1){
            FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_hotel_main where hotelid='%d'",item.idNum]];
            
            while ([set next]) {
                CItem *ci=[[CItem alloc]init];
                ci.name=[set objectForColumnName:@"hotelname"];
                ci.score=[[set objectForColumnName:@"score"]floatValue];
                ci.address=[set objectForColumnName:@"address"];
                ci.img=@"bg_h_s1";
                ci.idNum=[[set objectForColumnName:@"hotelid"]integerValue];

                ci.type=@"listdo_hotel_main";
                [zhusu addObject:ci];
                
            }
        }
        else if ([item.title isEqualToString:@"listdo_relax_main"]==1){
            FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_relax_main where scenicid='%d'",item.idNum]];
            
            while ([set next]) {
                CItem *ci=[[CItem alloc]init];
                ci.name=[set objectForColumnName:@"scenicname"];
                ci.score=[[set objectForColumnName:@"score"]floatValue];
                ci.address=[set objectForColumnName:@"address"];
                ci.img=@"bg_l_s1";
                 ci.type=@"listdo_relax_main";
                ci.idNum=[[set objectForColumnName:@"scenicid"]integerValue];

                [yule addObject:ci];
               
            }
        }
                     
    }
    [db close];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    
    CItem *item=[dataArray objectAtIndex:indexPath.row];
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 75)];
    UIImageView *img2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Link_bg1"]];
    
    img2.frame=CGRectMake(0, 0, 320, 75);
    [backView addSubview:img2];
    UIImageView *img3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",item.img]]];
    
    img3.frame=CGRectMake(5, 10,20, 20);
    [img2 addSubview:img3];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 200, 20)];
    label.text=item.name;
    label.backgroundColor=[UIColor clearColor];
    [backView addSubview:label];
    
    UIImageView *img4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"star_%d",(int)item.score]]];
    img4.frame=CGRectMake(40, 30, 69, 13);
    [img2 addSubview:img4];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(40, 45, 260, 20)];
    la1.text=item.address;
    la1.font=[UIFont systemFontOfSize:14];
    la1.backgroundColor=[UIColor clearColor];
    la1.numberOfLines=0;
    [backView addSubview:la1];
    
    
    
    [cell.contentView addSubview:backView];
    
    
    return cell;
    
    
}
-(void)next:(UITapGestureRecognizer *)tap{
    
    for(int i=100;i<106;i++){
        if(tap.view.tag==i){
            UIImageView *img=(UIImageView *)tap.view;
            img.image=[UIImage imageNamed:@"fav_lei_sed"];
        }
        else{
            UIImageView *img=(UIImageView *)[self.view viewWithTag:i];
            img.image=[UIImage imageNamed:@"fav_lei_nor"];
           
        }
    }
   
    [dataArray removeAllObjects];
    
    [dataArray addObjectsFromArray:[arrayBaokuo objectAtIndex:tap.view.tag-100]];
    [myTableView reloadData];
    
    if([dataArray count]==0){
        
        smile.hidden=NO;
        
        [self.view bringSubviewToFront:smile];
              
    }
    else{
        
                
        smile.hidden=YES;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CItem *item=[dataArray objectAtIndex:indexPath.row];
  
    if([item.type isEqualToString:@"listdo_scenic_main"]){
        Ceshi3ViewController *ce=[[Ceshi3ViewController alloc]init];
        ce.linkid=item.idNum;
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
    else if([item.type isEqualToString:@"listdo_shopping_main"]){
        Ceshi4ViewController *ce=[[Ceshi4ViewController alloc]init];
        ce.linkid=item.idNum;
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
    else if([item.type isEqualToString:@"listdo_food_restaurant"]){
        Ceshi5ViewController *ce=[[Ceshi5ViewController alloc]init];
        ce.linkid=item.idNum;
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
    else if([item.type isEqualToString:@"listdo_hotel_main"]){
        HotelTableViewController *ho=[[HotelTableViewController alloc]init];
        ho.linkid=item.idNum;
        [self.navigationController pushViewController:ho animated:YES];
        [ho release];
    }
    else if([item.type isEqualToString:@"listdo_relax_main"]){
        RelaxTableViewController *re=[[RelaxTableViewController alloc]init];
        re.linkid=item.idNum;
        [self.navigationController pushViewController:re animated:YES];
        [re release];
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
