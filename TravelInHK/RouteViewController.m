//
//  RouteViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "RouteViewController.h"
#import "FMDatabase.h"
#import "Ceshi1ViewController.h"
@interface RouteViewController ()

@end

@implementation RouteViewController
@synthesize path;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setToolbarHidden:NO];
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
    self.navigationItem.title=@"线路";
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
     arrayTitle=[[NSMutableArray alloc]init];
    FMResultSet *set=[db executeQuery:@"select * from listdo_travel_plans"];
   
    NSString *datastr=[NSString string];
    NSString *dataDes=[NSString string];
    NSString *dataImg=[NSString string];
    NSString *dataId=[NSString string];
    arrayDes=[[NSMutableArray alloc]init];
    arrayImg=[[NSMutableArray alloc]init];
    arrayPlanId=[[NSMutableArray alloc]init];
    while([set next]){
        datastr=[set objectForColumnName:@"planname"];
        [arrayTitle addObject:datastr];
        dataDes=[set objectForColumnName:@"description"];
        [arrayDes addObject:dataDes];
        dataImg=[set objectForColumnName:@"logo"];
        [arrayImg addObject:[[dataImg componentsSeparatedByString:@"/"]objectAtIndex:1]];
        dataId=[set objectForColumnName:@"planid"];
        [arrayPlanId addObject:dataId];
       
    }
    [db close];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    scrollView.contentSize=CGSizeMake(320, 187*7-100);
    
    [self.view addSubview:scrollView];
    
    
    NSArray *arrayNum=[NSArray arrayWithObjects:@"4",@"3",@"2",@"2",@"3",@"3",@"2",nil];
    
    for(int i=0;i<[arrayImg count];i++){
        UIImageView  *i1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[arrayImg objectAtIndex:i]]];
    i1.frame=CGRectMake(10, 20+167*i, 300, 130);
    [scrollView addSubview:i1];
    
    UIImageView *imgbg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_list_cellbg"]];
    imgbg.frame=CGRectMake(10, 20+167*i, 300, 167);
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(90, 126, 180, 20)];
    label1.text=[arrayTitle objectAtIndex:i];
    [imgbg addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(20, 90, 50, 50)];
        label2.text=[arrayNum objectAtIndex:i];
    label2.backgroundColor=[UIColor clearColor];
    label2.textColor=[UIColor whiteColor];
    label2.font=[UIFont systemFontOfSize:50];
    [imgbg addSubview:label2];
        UITapGestureRecognizer *gest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextPage:)];
        gest.numberOfTapsRequired=1;
        gest.numberOfTouchesRequired=1;
        [i1 addGestureRecognizer:gest];
        i1.userInteractionEnabled=YES;
    i1.tag=i+100;
    [scrollView addSubview:imgbg];
    }
}
-(void)nextPage:(UITapGestureRecognizer *)tap{
    UIView *view=tap.view;
    Ceshi1ViewController *ce=[[Ceshi1ViewController alloc]init];
    ce.titleName=[arrayTitle objectAtIndex:view.tag-100];
    ce.planid=[arrayPlanId objectAtIndex:view.tag-100];
    ce.descri=[arrayDes objectAtIndex:view.tag-100];
    [self.navigationController pushViewController:ce animated:YES];
    [ce release];
    
 /*
    UIView *view= tap.view;
    switch (view.tag) {
        case 100:
        {
            Page1ViewController *page1=[[Page1ViewController alloc]init];
            page1.titleName=[arrayTitle objectAtIndex:0];
            page1.descri=[arrayDes objectAtIndex:0];
            [self.navigationController pushViewController:page1 animated:YES];
            [page1 release];
        }
            break;
            
        case 101:
        {
            Page2ViewController *page1=[[Page2ViewController alloc]init];
            page1.titleName=[arrayTitle objectAtIndex:1];
            page1.descri=[arrayDes objectAtIndex:1];
            [self.navigationController pushViewController:page1 animated:YES];
            [page1 release];
        }
            break;
        case 102:
        {
            Page3ViewController *page1=[[Page3ViewController alloc]init];
            page1.titleName=[arrayTitle objectAtIndex:2];
            page1.descri=[arrayDes objectAtIndex:2];

            [self.navigationController pushViewController:page1 animated:YES];
            [page1 release];
        }
            break;
        case 103:
        {
            Page4ViewController *page1=[[Page4ViewController alloc]init];
            page1.titleName=[arrayTitle objectAtIndex:3];
            page1.descri=[arrayDes objectAtIndex:3];

            [self.navigationController pushViewController:page1 animated:YES];
            [page1 release];
        }
            break;
        case 104:
        {
            Page5ViewController *page1=[[Page5ViewController alloc]init];
            page1.titleName=[arrayTitle objectAtIndex:4];
            page1.descri=[arrayDes objectAtIndex:4];

            [self.navigationController pushViewController:page1 animated:YES];
            [page1 release];
        }
            break;
        case 105:
        {
            Page6ViewController *page1=[[Page6ViewController alloc]init];
            page1.titleName=[arrayTitle objectAtIndex:5];
            page1.descri=[arrayDes objectAtIndex:5];

            [self.navigationController pushViewController:page1 animated:YES];
            [page1 release];
        }
            break;
        case 106:
        {
            Page7ViewController *page1=[[Page7ViewController alloc]init];
            page1.titleName=[arrayTitle objectAtIndex:6];
            page1.descri=[arrayDes objectAtIndex:6];

            [self.navigationController pushViewController:page1 animated:YES];
            [page1 release];
        }
            break;
       
            
        default:
            break;
    }
    
    
    
   */
    
}
-(void)clicked:(UIButton *)button{
    NSLog(@"点击");
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
