//
//  Ceshi5ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-10.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Ceshi5ViewController.h"
#import "FMDatabase.h"
#import "Ceshi51ViewController.h"
#import "Ceshi52ViewController.h"
@interface Ceshi5ViewController ()

@end

@implementation Ceshi5ViewController
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
    
    
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_food_restaurant where restaurant_id='%d'",linkid]];
     NSMutableString *  restaurant_name=[[NSMutableString alloc]init];
    
    NSMutableString *restaurant_recommended_dishes=[[NSMutableString alloc]init];
    
    NSMutableString *restaurant_consumption_pp=[[NSMutableString alloc]init];
    
        
    NSMutableString *restaurant_Business_hours=[[NSMutableString alloc]init];
    
    NSMutableString *restaurant_tel=[[NSMutableString alloc]init];
    
    NSMutableString * restaurant_address=[[NSMutableString alloc]init];
    
    NSMutableString *restaurant_introduce=[[NSMutableString alloc]init];
    NSMutableString *restaurant_traffic_tip=[[NSMutableString alloc]init];
    while ([set next]) {
        restaurant_name=[set objectForColumnName:@"restaurant_name"];//名字
        restaurant_consumption_pp=[set objectForColumnName:@"restaurant_consumption_pp"];//人均消费
         restaurant_Business_hours=[set objectForColumnName:@"restaurant_Business_hours"];//营业时间
        
        restaurant_traffic_tip=[set objectForColumnName:@"restaurant_traffic_tip"];//交通信息
        restaurant_address=[set objectForColumnName:@"restaurant_address"];//地址
        restaurant_tel=[set objectForColumnName:@"restaurant_tel"];//电话
        restaurant_introduce=[set objectForColumnName:@"restaurant_introduce"];//推荐理由
        restaurant_recommended_dishes=[set objectForColumnName:@"restaurant_recommended_dishes"];//推荐菜
      
    }
    [db close];
    
    self.navigationItem.title=restaurant_name;
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 130)];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 280, 20)];
    label1.text=@"概况：";
    label1.backgroundColor=[UIColor clearColor];
    [view addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 250, 20)];
    label2.text=[NSString stringWithFormat:@"人均消费：%@",restaurant_consumption_pp];
   
    label2.font=[UIFont systemFontOfSize:14];
    label2.backgroundColor=[UIColor clearColor];
    [view addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 250, 20)];
  
    label3.font=[UIFont systemFontOfSize:14];
     label3.backgroundColor=[UIColor clearColor];
    label3.text=[NSString stringWithFormat:@"营业时间：%@",restaurant_Business_hours];
    [view addSubview:label3];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, 250, 20)];
    label4.font=[UIFont systemFontOfSize:14];
     label4.backgroundColor=[UIColor clearColor];
    label4.text=[NSString stringWithFormat:@"交通信息：%@",restaurant_traffic_tip];
      [view addSubview:label4];
    UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    im.frame=CGRectMake(265, 31, 13, 18);
    [view addSubview:im];
    [dataArray addObject:view];
    
        
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *im4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Detail_map_icon"]];
    im4.frame=CGRectMake(10, 15, 20, 20);
    [view3 addSubview:im4];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 250, 40)];
    label5.numberOfLines=0;
    label5.font=[UIFont systemFontOfSize:14];
    label5.backgroundColor=[UIColor clearColor];
    label5.text=restaurant_address;
    [view3 addSubview:label5];
    [ dataArray addObject:view3];
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *im5=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Detail_phone_icon"]];
    im5.frame=CGRectMake(10, 15, 20, 20);
    [view4 addSubview:im5];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 240, 40)];
    label6.numberOfLines=0;
     label6.font=[UIFont systemFontOfSize:14];
    label6.backgroundColor=[UIColor clearColor];
    if([restaurant_tel length]==0){
        label6.text=@"暂无电话";
        [view4 addSubview:label6];
        [ dataArray addObject:view4];
        
    }
    else{
        label6.text= restaurant_tel;
        [view4 addSubview:label6];
        [ dataArray addObject:view4];
        
    }
    
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 120)];
    UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    label7.text=@"推荐理由：";
    label7.backgroundColor=[UIColor clearColor];
    [view5 addSubview:label7];
    UILabel *label8=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 230, 80)];
    label8.text=restaurant_introduce;
    label8.backgroundColor=[UIColor clearColor];
    label8.numberOfLines=0;
    label8.font=[UIFont systemFontOfSize:14];
    [view5 addSubview:label8];
    UIImageView *im11=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    im11.frame=CGRectMake(265,40, 13, 18);
    [view5 addSubview:im11];
    [ dataArray addObject:view5];
    
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 85)];
    UILabel *label9= [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    label9.text=@"推荐菜 ：";
    label9.backgroundColor=[UIColor clearColor];
    UILabel *label10=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 280, 50)];
    label10.text=restaurant_recommended_dishes;
    label10.numberOfLines=0;
    label10.font=[UIFont systemFontOfSize:14];
    label10.backgroundColor=[UIColor clearColor];
    [view6 addSubview:label10];
    [view6 addSubview:label9];
    
    [ dataArray addObject:view6];
    
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            return 105.0f;
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
       
        FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_food_restaurant where restaurant_id='%d'",linkid]];
        while ([set next]) {
            strImg=[[[set objectForColumnName:@"restaurant_logo"]componentsSeparatedByString:@"/"]objectAtIndex:1];
            
        }
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
        
        UIImageView *view2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:strImg]];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell.contentView addSubview:[dataArray objectAtIndex:(indexPath.section * 3 + indexPath.row)]];

    return cell;
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
        
        res=[db executeUpdate:[NSString stringWithFormat: @"INSERT INTO FVRT (id,title) VALUES (%d,'listdo_food_restaurant')",linkid]];
        
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
-(void)clicked:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            Ceshi51ViewController *ce=[[Ceshi51ViewController alloc]init];
            ce.restaurant_id=linkid;
            [self.navigationController pushViewController:ce animated:YES];
            [ce release];
        }
    }
    if(indexPath.section==1){
        Ceshi52ViewController *ce=[[Ceshi52ViewController alloc]init];
        ce.restaurant_id=linkid;
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
