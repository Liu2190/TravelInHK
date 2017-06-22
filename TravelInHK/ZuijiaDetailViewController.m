//
//  ZuijiaDetailViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "ZuijiaDetailViewController.h"
#import "FMDatabase.h"
@interface ZuijiaDetailViewController ()

@end

@implementation ZuijiaDetailViewController
@synthesize path,dataid;
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
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select  * from listdo_guide_data_main where dataid='%d'",dataid]];
    while ([set next]) {
        restaurant_name=[set objectForColumnName:@"title"];
        restaurant_introduce=[set objectForColumnName:@"content"];//推荐理由
    }
    [db close];
    self.navigationItem.title=restaurant_name;
   
   
    
    
    UIWebView *web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    web.delegate=self;
    web.dataDetectorTypes=UIDataDetectorTypeAll;
    [web loadHTMLString:restaurant_introduce baseURL:nil];
    
    [self.view addSubview:web];
    [web release];
    
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
