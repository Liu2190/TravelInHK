//
//  TushuoViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "TushuoViewController.h"

@interface TushuoViewController ()

@end

@implementation TushuoViewController

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
    //[self.navigationController setToolbarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"图说香港";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    UIScrollView *view=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    view.pagingEnabled=YES;
    [self.view addSubview:view];
    view.contentSize=CGSizeMake(320*9, 460-44);
    NSArray *array1=[NSArray arrayWithObjects:@"4265_1339579905", @"4265_1339579919",@"4265_1339579933",@"4265_1339579969",@"4265_1339579984",@"4265_1339579997",@"4265_1339580005",@"4265_1339580015",@"4265_1339580110",nil];
    for(int i=0;i<[array1 count];i++){
        UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[array1 objectAtIndex:i]]]];
        img.frame=CGRectMake(320*i, 0, 320, 460-44);
        [view addSubview:img];
    }
    
    
}
-(void)clicked:(UIButton *)button{
   
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
