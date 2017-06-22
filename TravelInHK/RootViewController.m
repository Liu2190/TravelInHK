//
//  RootViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "UIImage+Scale.h"
#import "RouteViewController.h"
#import "SceneViewController.h"
#import "HotelViewController.h"
#import "FoodViewController.h"
#import "ShopViewController.h"
#import "EntViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"
#import "ZuijiaViewController.h"
#import "ChufangViewController.h"
#import "JiaotongViewController.h"
#import "TushuoViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
               [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"home_icon_on"] withFinishedUnselectedImage:[UIImage imageNamed:@"home_icon"]];
       
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
   
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
  //  self.navigationController.navigationBarHidden=YES;
       
	detailView=[[[[NSBundle mainBundle]loadNibNamed:@"Detail" owner:self options:nil]lastObject]retain];
    [self.view addSubview:detailView];
    detailView.frame=self.view.bounds;
    detailView.delegate=self;
    cueView=[[UIView alloc]initWithFrame:CGRectMake(120, 180, 164, 172)];
    UIImageView *igv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LV_HOME_pop_bg"]];
    NSArray *array=[NSArray arrayWithObjects:@"最佳体验",@"初访必读",@"交通",@"图说香港",nil];
    NSArray *array1=[NSArray arrayWithObjects:@"LV_HOME_zuijia", @"LV_HOME_chufang",@"LV_HOME_jiaotong",@"LV_HOME_tushuo",nil];
    for(int i=0;i<[array count];i++){
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.Frame=CGRectMake(20 +(i%2)*75, 10 +(i/2)*75, 50, 50);
        [button setBackgroundImage:[UIImage imageNamed:[array1 objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+10;
        [igv addSubview:button];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15 +(i%2)*75, 60 +(i/2)*70, 60,20)];
        label.text=[array objectAtIndex:i];
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:12];
        label.textAlignment=NSTextAlignmentCenter;
        [igv addSubview:label];
        
    }
     igv.userInteractionEnabled = YES;
    [cueView addSubview:igv];
    [self.view addSubview:cueView];
    cueView.hidden=YES;
    
}

-(void)clicked:(UIButton *)button{
  
    switch (button.tag) {
        case 10:
        {
            
            ZuijiaViewController *z=[[ZuijiaViewController alloc]init];
            [self.navigationController pushViewController:z animated:YES];
            [z release];
        }
            break;
        case 11:{
           
            ChufangViewController *c=[[ChufangViewController alloc]init];
            [self.navigationController pushViewController:c animated:YES];
            [c release];
        }
            break;
        case 12:{
          
            JiaotongViewController *j=[[JiaotongViewController alloc]init];
            [self.navigationController pushViewController:j animated:YES];
            [j release];
        }
            break;
        case 13:{
          
            TushuoViewController *t=[[TushuoViewController alloc]init];
            [self.navigationController pushViewController:t animated:YES];
            [t release];
        }            break;
        default:
            break;
            
            
        
    }
}
-(void)pushDetail:(UIButton * )button{
    switch (button.tag) {
        case 1:
        {
            RouteViewController *rvc=[[RouteViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rvc animated:YES];
            [rvc release];
        }
            break;
        case 2:{
            SceneViewController *svc=[[SceneViewController alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
            [svc release];
        }
            break;
        case 3:{
            HotelViewController *hvc=[[HotelViewController alloc]init];
            [self.navigationController pushViewController:hvc animated:YES];
            [hvc release];
        }
            break;
        case 4:{
            FoodViewController *fvc=[[FoodViewController alloc]init];
            [self.navigationController pushViewController:fvc animated:YES];
            [fvc release];
        }
            break;
        case 5:{
            ShopViewController *svc=[[ShopViewController alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
            [svc release];
        }
            break;
        case 6:{
            EntViewController *evc=[[EntViewController alloc]init];
            [self.navigationController pushViewController:evc animated:YES];
            [evc release];
        }
            break;
        case 7:{
            cueView.hidden=NO;
        }
            break;
        case 8:{
            NewsViewController *nvs=[[NewsViewController alloc]init];
            [self.navigationController pushViewController:nvs animated:YES];
            [nvs release];
        }
            break;
        case 9:{
//            SearchViewController *svc=[[SearchViewController alloc]init];
//            [self.navigationController pushViewController:svc animated:YES];
//            [svc release];
        }
        default:
            break;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    cueView.hidden=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
