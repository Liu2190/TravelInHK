//
//  Ceshi51ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-11.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Ceshi51ViewController.h"
#import "FMDatabase.h"

@interface Ceshi51ViewController ()

@end

@implementation Ceshi51ViewController
@synthesize restaurant_id,path;
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;

    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
    
    
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_food_restaurant where restaurant_id='%d'",restaurant_id]];
    NSMutableString *  restaurant_name=[[NSMutableString alloc]init];
    
   
    
    NSMutableString *restaurant_consumption_pp=[[NSMutableString alloc]init];
    
    
    NSMutableString *restaurant_Business_hours=[[NSMutableString alloc]init];
    
    NSMutableString *restaurant_tel=[[NSMutableString alloc]init];
    
    NSMutableString * restaurant_address=[[NSMutableString alloc]init];
    
  
    NSMutableString *restaurant_traffic_tip=[[NSMutableString alloc]init];
    while ([set next]) {
        restaurant_name=[set objectForColumnName:@"restaurant_name"];//名字
        restaurant_consumption_pp=[set objectForColumnName:@"restaurant_consumption_pp"];//人均消费
        restaurant_Business_hours=[set objectForColumnName:@"restaurant_Business_hours"];//营业时间
        
        restaurant_traffic_tip=[set objectForColumnName:@"restaurant_traffic_tip"];//交通信息
        restaurant_address=[set objectForColumnName:@"restaurant_address"];//地址
        restaurant_tel=[set objectForColumnName:@"restaurant_tel"];//电话
     
        
    }
    [db close];
    float y=0;
   
    self.navigationItem.title=restaurant_name;
       
    NSArray *array1=[NSArray arrayWithObjects:@"地址：",@"预定电话：",@"人均消费：",@"营业时间：",@"交通：", nil];
    NSArray *array2=[NSArray arrayWithObjects: restaurant_address,
                     restaurant_tel,restaurant_consumption_pp,restaurant_Business_hours,restaurant_traffic_tip,nil];
    for(int i=0;i<[array1 count];i++){

        NSString *str=[NSString stringWithFormat:@"%@%@",[array1 objectAtIndex:i],[array2 objectAtIndex:i]];
        UIFont *f=[UIFont fontWithName:@"Arial" size:14];
        CGSize maxSize=CGSizeMake(300,600);
        CGSize size=[str sizeWithFont:f constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        UILabel *label=[[UILabel alloc]init];
        label.text=str;
        label.backgroundColor=[UIColor clearColor];
        label.font=f;
        label.numberOfLines=0;
        label.frame=CGRectMake(10, y+5, 300, size.height+15);
        [self.view addSubview:label];
        y=y+size.height+20;
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Detail_content_line"]];
        im.frame=CGRectMake(0, y, 320, 1) ;
        [self.view addSubview:im];
        
        
    
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
