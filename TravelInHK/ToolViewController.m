//
//  ToolViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "ToolViewController.h"
#import "TianqiViewController.h"
#import "DitieViewController.h"
#import "ChangyongViewController.h"
#import "HangkongViewController.h"
#import "ShijieViewController.h"
#import "HuobiViewController.h"
#import "YijianViewController.h"
@interface ToolViewController ()

@end

@implementation ToolViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tools_icon_on"] withFinishedUnselectedImage:[UIImage imageNamed:@"tools_icon"]];
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
    
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"工具箱";
    
    UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Toolbox-separator"]];
    view.frame=CGRectMake(0, 0, 320, 160);
    view.userInteractionEnabled=YES;
    [self.view addSubview:view];
    [view release];
    
    
    NSArray *ar1=[NSArray arrayWithObjects:@"天气预报",@"香港地铁",@"常用电话",@"航空电话",@"世界时间",@"货币换算",@"意见反馈", nil];
    NSArray *ar2=[NSArray arrayWithObjects:@"Icon_in8",@"Icon_in4",@"Icon_in3",@"Icon_in7",@"Icon_in2",@"Icon_in1",@"Icon_in5", nil];
    
    for(int i=0;i<[ar1 count];i++){
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[ar2 objectAtIndex:i]]];
        im.frame=CGRectMake( 15+80*(i%4),5+80*(i/4), 50, 50);
        [view addSubview:im];
        im.tag=100+i;
        im.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(next:)];
        [im addGestureRecognizer:tap];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*(i%4),  55+80*(i/4),80, 20)];
        label.text=[ar1 objectAtIndex:i];
        label.textAlignment=NSTextAlignmentCenter;
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:16];
        [view addSubview:label];
    }
    
    
    
    
    
}
-(void)next:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
        case 100:
        {
            TianqiViewController *ti=[[TianqiViewController alloc]init];
            [self.navigationController pushViewController:ti animated:YES];
            [ti release];
            
        }
            break;
        case 101:
        {
            DitieViewController *di=[[DitieViewController alloc]init];
            [self.navigationController pushViewController:di animated:YES];
            [di release];
            
        }
            break;
        case 102:
        {
            ChangyongViewController *ch=[[ChangyongViewController alloc]init];
            [self.navigationController pushViewController:ch animated:YES];
            [ch release];
        }
            break;
        case 103:
        {
            HangkongViewController *ha=[[HangkongViewController alloc]init];
            [self.navigationController pushViewController:ha animated:YES];
            [ha release];
        }
            break;
        case 104:
        {
            ShijieViewController *sh=[[ShijieViewController alloc]init];
            [self.navigationController pushViewController:sh animated:YES];
            [sh release];
        }
            break;
        case 105:
        {
            HuobiViewController *hu=[[HuobiViewController alloc]init];
            [self.navigationController pushViewController:hu animated:YES];
            [hu release];
        }
            break;
        case 106:
        {
            YijianViewController *yi=[[YijianViewController alloc]init];
            [self.navigationController pushViewController:yi animated:YES];
            [yi release];
            
        }
            break;
     
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
