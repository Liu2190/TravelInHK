//
//  HotelTableViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "HotelTableViewController.h"
#import "FMDatabase.h"
#import "Hotel1ViewController.h"
#import "Hotel2ViewController.h"
@interface HotelTableViewController ()

@end

@implementation HotelTableViewController
@synthesize linkid,path,linktype,path1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    view99=[[UIImageView alloc]init];
    view99.frame=CGRectMake(10, 160, 30, 30);
    
    self.path1=[[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"news.db"];
    FMDatabase *db1=[FMDatabase databaseWithPath:path1];
    BOOL res=[db1 open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
    int flag=0;
    FMResultSet *set=[db1 executeQuery:@"select * from FVRT"];
    while ([set next]) {
        NSString *str=[set objectForColumnName:@"id"];
        if([str integerValue]==linkid){
            view99.image=[UIImage imageNamed:@"favorite_botton_on"];
            flag=1;
        }
    }
    [db1 close];
    if(flag==0){
        view99.image=[UIImage imageNamed:@"favorite_botton_off"];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=YES;
}
-(void)viewDidAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=YES;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    dataArray=[[NSMutableArray alloc]init];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    myTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStyleGrouped];
    myTableview.delegate=self;
    myTableview.dataSource=self;
    [self.view addSubview:myTableview];
    
    strImg=[[NSMutableString alloc]init];
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
     FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_hotel_main where hotelid='%d'",linkid]];

    NSMutableString *hotelname=[[NSMutableString alloc]init];
    NSMutableString *price=[[NSMutableString alloc]init];
    NSMutableString *price_room=[[NSMutableString alloc]init];
    NSMutableString *typename=[[NSMutableString alloc]init];
    NSMutableString *address=[[NSMutableString alloc]init];
    NSMutableString *telephone=[[NSMutableString alloc]init];
    NSMutableString *content=[[NSMutableString alloc]init];
    NSMutableString *comment=[[NSMutableString alloc]init];
    while ([set next]) {
        hotelname=[set objectForColumnName:@"hotelname"];
        price=[set objectForColumnName:@"price"];
        price_room=[set objectForColumnName:@"price_room"];
        typename=[set objectForColumnName:@"typename"];
        address=[set objectForColumnName:@"address"];
        telephone=[set objectForColumnName:@"telephone"];
        content=[set objectForColumnName:@"content"];
        comment=[set objectForColumnName:@"comment"];
    }
    [db close];
    self.navigationItem.title=hotelname;
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 85)];
    UILabel *v1l1=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 280, 20)];
    v1l1.text=@"概况：";
    v1l1.backgroundColor=[UIColor clearColor];
    [v1 addSubview:v1l1];
    
    UILabel *v1l2=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 250, 20)];
    v1l2.text=[NSString stringWithFormat:@"参考价格：%@港币(%@)",price,price_room];
    v1l2.font=[UIFont systemFontOfSize:14];
    v1l2.backgroundColor=[UIColor clearColor];
    [v1 addSubview:v1l2];
    
    UILabel *v1l3=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, 250, 20)];
    v1l3.text=[NSString stringWithFormat:@"酒店类型：%@",typename];
    
    v1l3.backgroundColor=[UIColor clearColor];
    v1l3.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:v1l3];
    
    UIImageView *v1m1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    v1m1.frame=CGRectMake(270, 28, 13, 18);
    [v1 addSubview:v1m1];
    [dataArray addObject:v1];
    
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *v2m1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Detail_map_icon"]];
    v2m1.frame=CGRectMake(10, 15, 20, 20);
    [v2 addSubview:v2m1];
    
    UILabel *v2l1=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 250, 40)];
    v2l1.numberOfLines=0;
    v2l1.font=[UIFont systemFontOfSize:14];
    v2l1.backgroundColor=[UIColor clearColor];
    v2l1.text=address;
    [v2 addSubview:v2l1];
    [dataArray addObject:v2];
    
    UIView *v3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *v3m1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Detail_phone_icon"]];
    v3m1.frame=CGRectMake(10, 15, 20, 20);
    [v3 addSubview:v3m1];
    UILabel *v3l1=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 240, 40)];
    v3l1.numberOfLines=0;
    v3l1.text=telephone;
    v3l1.font=[UIFont systemFontOfSize:14];
    v3l1.backgroundColor=[UIColor clearColor];
    [v3 addSubview:v3l1];
    [dataArray addObject:v3];
    
    UIView *v4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 120)];
    UILabel *v4l1=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    v4l1.text=@"简介：";
    v4l1.backgroundColor=[UIColor clearColor];
    [v4 addSubview:v4l1];
    
    UILabel *v4l2=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 230, 80)];
    v4l2.text=content;
    v4l2.backgroundColor=[UIColor clearColor];
    v4l2.numberOfLines=0;
    v4l2.font=[UIFont systemFontOfSize:14];
    [v4 addSubview:v4l2];
    
    UIImageView *v4m1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    v4m1.frame=CGRectMake(265, 40, 13, 18);
    [v4 addSubview:v4m1];
    [dataArray addObject:v4];
    
    UIView *v5=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 85)];
    UILabel *v5l1=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    v5l1.text=@"旅人评价：";
    v5l1.backgroundColor=[UIColor clearColor];
    UILabel *v5l2=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 280, 50)];
    v5l2.text=comment;
    v5l2.numberOfLines=0;
    v5l2.font=[UIFont systemFontOfSize:14];
    v5l2.textColor=[UIColor brownColor];
    [v5 addSubview:v5l1];
    [v5 addSubview:v5l2];
    [dataArray addObject:v5];
    [dataArray addObject:v5];
    [dataArray addObject:v5];
    [dataArray addObject:v5];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            return 85.0f;
        }
        else {
            return 50.0f;
        }
    }
    else if(indexPath.section==1){
        return 120.0f;
    }
    return 85.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 200;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section==0){
        self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
        FMDatabase *db=[FMDatabase databaseWithPath:path];
        
        BOOL res=[db open];
        if(res==NO){
            NSLog(@"打开失败");
            return nil;
        }
        
        FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_hotel_main  where hotelid='%d'",linkid]];
        while ([set next]) {
            strImg=[set objectForColumnName:@"imageid"];
            
        }
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
        
        UIImageView *view2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",strImg]]];
        view2.frame=CGRectMake(0, 0, 320, 200);
        [view1 addSubview:view2];
        [view2 release];
        
      
        [view2 addSubview:view99];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DataInorOut:)];
        [view99 addGestureRecognizer:tap];
        view99.userInteractionEnabled=YES;
        view2.userInteractionEnabled=YES;
        view1.userInteractionEnabled=YES;
        return view1;
    }
    else{
        return nil;
    }
}

-(void)DataInorOut:(UITapGestureRecognizer *)tap{
    UIImageView *im=(UIImageView *)tap.view;
    
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"news.db"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        
    }
    
    if(im.image==[UIImage imageNamed:@"favorite_botton_off"]){
        im.image=[UIImage imageNamed:@"favorite_botton_on"];
        
        res=[db executeUpdate:[NSString stringWithFormat: @"INSERT INTO FVRT (id,title) VALUES (%d,'listdo_hotel_main')",linkid]];
        
        if(res==NO){
            
            NSLog(@"失败%@",[db lastErrorMessage]);
            
        }
        else{
            NSLog(@"成功");
        }
        
    }
    else{
        im.image=[UIImage imageNamed:@"favorite_botton_off"];
        
        NSString *sql=[NSString stringWithFormat:@" DELETE FROM FVRT WHERE id = '%d'",linkid];
        
        res= [db executeUpdate:sql];
        if(res==NO){
            
            NSLog(@"失败%@",[db lastErrorMessage]);
            
        }
        else{
            NSLog(@"成功");
        }
        
    }
    
    [db close];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell.contentView addSubview:[dataArray objectAtIndex:(indexPath.section * 3 + indexPath.row)]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
           Hotel1ViewController *ce=[[Hotel1ViewController alloc]init];
            ce.hotelid=linkid;
            [self.navigationController pushViewController:ce animated:YES];
            [ce release];
        }
    }
    if(indexPath.section==1){
       Hotel2ViewController *ce=[[Hotel2ViewController alloc]init];
        ce.hotelid=linkid;
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
}


-(void)clicked:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
