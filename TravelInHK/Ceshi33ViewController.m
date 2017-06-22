//
//  Ceshi33ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-11.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Ceshi33ViewController.h"
#import "FMDatabase.h"
@interface Ceshi33ViewController ()

@end

@implementation Ceshi33ViewController
@synthesize path,scenicid;
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
    NSMutableString * restaurant_introduce=[[NSMutableString alloc]init];
    NSMutableString * restaurant_name=[[NSMutableString alloc]init];
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_scenic_main where scenicid='%d'",scenicid]];
    while ([set next]) {
        restaurant_name=[set objectForColumnName:@"scenicname"];
        restaurant_introduce=[set objectForColumnName:@"content"];//推荐理由
    }
    [db close];
    UIScrollView *view=[[UIScrollView alloc]init];
    [self.view addSubview:view];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,10, 320, 60)];
    label.text=restaurant_name;
    label.font=[UIFont systemFontOfSize:18];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    [view addSubview:label];
    
    UIFont *f=[UIFont fontWithName:@"Arial" size:14];
    CGSize maxSize=CGSizeMake(300,2000);
    CGSize size=[restaurant_introduce sizeWithFont:f constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *label1=[[UILabel alloc]init];
    label1.numberOfLines=0;
    label1.backgroundColor=[UIColor clearColor];
    label1.font=f;
    label1.text=restaurant_introduce;
    [view addSubview:label1];
    label1.frame=CGRectMake(5, 70, 300, size.height+5);
    view.frame=CGRectMake(0, 0, 320, 460-44);
    view.contentSize=CGSizeMake(320, 70+size.height+10);
    
    
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
