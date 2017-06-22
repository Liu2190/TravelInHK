//
//  Ceshi32ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-11.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Ceshi32ViewController.h"
#import "FMDatabase.h"
@interface Ceshi32ViewController ()

@end

@implementation Ceshi32ViewController
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
        restaurant_introduce=[set objectForColumnName:@"price_details"];//推荐理由
    }
    [db close];
    self.navigationItem.title=restaurant_name;
    NSArray *array=[restaurant_introduce componentsSeparatedByString:@"<br />"];
    NSMutableString *str=[[NSMutableString alloc]init];
    for(int i=0;i<[array count];i++){
        [str appendString:[array objectAtIndex:i]];
    }
    
    UIFont *f=[UIFont fontWithName:@"Arial" size:15];
    CGSize maxSize=CGSizeMake(300,2000);
    CGSize size=[str sizeWithFont:f constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *label1=[[UILabel alloc]init];
    label1.numberOfLines=0;
    label1.backgroundColor=[UIColor clearColor];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=f;
    label1.text=str;
    
    label1.frame=CGRectMake(5, 20, 300, size.height+5);
    [self.view addSubview:label1];
    
    
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
