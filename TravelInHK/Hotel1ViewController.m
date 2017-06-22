//
//  Hotel1ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Hotel1ViewController.h"
#import "FMDatabase.h"
@interface Hotel1ViewController ()

@end

@implementation Hotel1ViewController
@synthesize hotelid,path;
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
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_hotel_main  where hotelid='%d'",hotelid]];
    NSMutableString *hotelname=[[NSMutableString alloc]init];
    NSMutableString *typename=[[NSMutableString alloc]init];
    NSMutableString *price=[[NSMutableString alloc]init];
    NSMutableString *price_room=[[NSMutableString alloc]init];
    NSMutableString *telephone=[[NSMutableString alloc]init];
    NSMutableString *fax=[[NSMutableString alloc]init];
    NSMutableString *address=[[NSMutableString alloc]init];
    while ([set next]) {
        hotelname=[set objectForColumnName:@"hotelname"];
        typename=[set objectForColumnName:@"typename"];
        price=[set objectForColumnName:@"price"];
        price_room=[set objectForColumnName:@"price_room"];
        telephone=[set objectForColumnName:@"telephone"];
        fax=[set objectForColumnName:@"fax"];
        address=[set objectForColumnName:@"address"];
    }
    [db close];
    NSMutableString *jiage=[[NSMutableString alloc]initWithFormat:@"%@(%@)",price,price_room ];
    self.navigationItem.title=hotelname;
    NSArray *array=[NSArray arrayWithObjects:@"地址：",@"预订电话：",@"传真：",@"参考价格：",@"酒店类型：", nil];
    NSArray *array1=[NSArray arrayWithObjects:address,telephone,fax,jiage,typename,nil];
    float y=0;

    for(int i=0;i<[array count];i++){
        if([[array1 objectAtIndex:i]length]!=0){
            NSString *str=[NSString stringWithFormat:@"%@%@",[array objectAtIndex:i],[array1 objectAtIndex:i]];
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
