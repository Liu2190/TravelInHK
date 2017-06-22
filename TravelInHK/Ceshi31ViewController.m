//
//  Ceshi31ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-11.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Ceshi31ViewController.h"
#import "FMDatabase.h"
@interface Ceshi31ViewController ()

@end

@implementation Ceshi31ViewController
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
    
    
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_scenic_main where scenicid='%d'",scenicid]];
    
    
    
    NSMutableString *strTi=[[NSMutableString alloc]init];
    NSMutableString *price_summary=[[NSMutableString alloc]init];//门票
    NSMutableString *open=[[NSMutableString alloc]init];//开放时间
    
    NSMutableString *close=[[NSMutableString alloc]init];//关闭时间
    NSMutableString *howlong=[[NSMutableString alloc]init];//游玩时长
    
    NSMutableString *telephone=[[NSMutableString alloc]init];//电话
    
    NSMutableString *address=[[NSMutableString alloc]init];//地址
    
    NSMutableString *arrival_bus=[[NSMutableString alloc]init];//交通信息公交
    NSMutableString *arrival_rail=[[NSMutableString alloc]init];//交通信息地铁
    NSMutableString *website=[[NSMutableString alloc]init];
    while ([set next]) {
        strTi=[set objectForColumnName:@"scenicname"];
        price_summary=[set objectForColumnName:@"price_summary"];//门票
         open=[set objectForColumnName:@"open"];//开放时间
        close=[set objectForColumnName:@"close"];//关闭时间
        howlong=[set objectForColumnName:@"howlong"];//游玩
        address=[set objectForColumnName:@"address"];//地址
        telephone=[set objectForColumnName:@"telephone"];//电话
       
        arrival_bus=[set objectForColumnName:@"arrival_bus"];//公交
        arrival_rail=[set objectForColumnName:@"arrival_rail"];//地铁
        
        website=[set objectForColumnName:@"website"];
    }
    [db close];
    
    self.navigationItem.title=strTi;
    float y=0;
    NSArray *array1=[NSArray arrayWithObjects:@"门票：",@"开放时间：",@"关闭时间：",@"游玩时长：",@"地址：",@"电话：" ,@"公交：",@"地铁：",@"官方网址：",nil];
    NSArray *array2=[NSArray arrayWithObjects:price_summary,open,close,howlong, address,telephone,arrival_bus,arrival_rail,website,nil];
    for(int i=0;i<[array1 count];i++){
        if([[array2 objectAtIndex:i] length]!=0){
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
