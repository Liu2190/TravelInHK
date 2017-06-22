//
//  NearByDetailViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-16.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "NearByDetailViewController.h"

@interface NearByDetailViewController ()

@end

@implementation NearByDetailViewController
@synthesize numid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array=[NSArray arrayWithObjects:@"附近景点",@"附近宾馆",@"附近美食",@"附近购物",@"附近娱乐",nil];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=[array objectAtIndex:numid];
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 38, 320, 460-44-38)];
    [self.view addSubview:view];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, 320, 20)];
    la1.textAlignment=NSTextAlignmentCenter;
    la1.backgroundColor=[UIColor clearColor];
    la1.text=@"-未搜索到任何数据-";
    [view addSubview:la1];
    
    
    
   all=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"List_tab_NO_right"]];
    all.frame=CGRectMake(0, 0, 160, 38);
    all.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allKinds:)];
    tap3.numberOfTapsRequired=1;
    tap3.numberOfTouchesRequired=1;
    [all addGestureRecognizer:tap3];
    [self.view addSubview:all];
    
   allTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 9, 120, 20)];
    allTitle.text=@"附近5公里";
    allTitle.backgroundColor=[UIColor clearColor];
    [all addSubview:allTitle];
    
    
    deImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"List_tab_NO_right"]];
    deImg.frame=CGRectMake(160, 0, 160, 38);
    UITapGestureRecognizer *tap5=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(defaultKinds:)];
    tap5.numberOfTouchesRequired=1;
    tap5.numberOfTapsRequired=1;
    deImg.userInteractionEnabled=YES;
    [deImg addGestureRecognizer:tap5];
    [self.view addSubview:deImg];
    
    defaultTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 9, 120, 20)];
    defaultTitle.text=@"距离排序";
    defaultTitle.backgroundColor=[UIColor clearColor];
    [deImg addSubview:defaultTitle];
    
   viewAll=[[UIView alloc]initWithFrame:CGRectMake(0, 38, 320, 240)];
    viewAll.hidden=YES;
    viewAll.userInteractionEnabled=YES;
    viewAll.backgroundColor=[UIColor blackColor];
    [self.view addSubview:viewAll];
    NSArray *array1=[NSArray arrayWithObjects:@"LV_Class_order_wu",@"LV_Class_order_san",@"LV_Class_order_yi",nil];
    array2=[[NSArray alloc]initWithObjects:@"附近5公里",@"附近3公里",@"附近1公里", nil];
    for(int i=0;i<[array1 count];i++){
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[array1 objectAtIndex:i]]];
        im.frame=CGRectMake(i%4*80, i/4*80, 80, 70);
        im.tag=1000+i;
        im.userInteractionEnabled=YES;
        UITapGestureRecognizer *gest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)];
        [im addGestureRecognizer:gest];
        [viewAll addSubview:im];
        
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(0, 55, 80, 15)];
        la.backgroundColor=[UIColor clearColor];
        la.textColor=[UIColor grayColor];
        la.text=[array2 objectAtIndex:i];
        la.font=[UIFont systemFontOfSize:13];
        la.textAlignment=NSTextAlignmentCenter;
        [im addSubview:la];
        
    }
    
    viewDef=[[UIView alloc]initWithFrame:CGRectMake(0, 38, 320, 240)];
    viewDef.hidden=YES;
    viewDef.userInteractionEnabled=YES;
    viewDef.backgroundColor=[UIColor blackColor];
    [self.view addSubview:viewDef];
    
    NSArray *array3=[NSArray arrayWithObjects:@"LV_Class_order_juli",@"LV_Class_order_pingfen",nil];
    array4=[[NSArray alloc]initWithObjects:@"距离排序",@"评分排序",nil];
    for(int i=0;i<[array3 count];i++){
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[array3 objectAtIndex:i]]];
        im.frame=CGRectMake(i%4*80, i/4*80, 80, 70);
        im.tag=2000+i;
        im.userInteractionEnabled=YES;
        UITapGestureRecognizer *gest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose1:)];
        [im addGestureRecognizer:gest];
        [viewDef addSubview:im];
        
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(0, 55, 80, 15)];
        la.backgroundColor=[UIColor clearColor];
        la.textColor=[UIColor grayColor];
        la.text=[array4 objectAtIndex:i];
        la.font=[UIFont systemFontOfSize:13];
        la.textAlignment=NSTextAlignmentCenter;
        [im addSubview:la];
    }
    
   
    
    
}
-(void)allKinds:(UITapGestureRecognizer *)tap{
    if(all.image ==[UIImage imageNamed:@"List_tab_NO_right"])
    {
        all.image=[UIImage imageNamed:@"List_tab_YES"];
        
        
    }
    else if(all.image ==[UIImage imageNamed:@"List_tab_YES"]){
        all.image=[UIImage imageNamed:@"List_tab_NO_right"];
    }
    if(viewAll.hidden==YES){
        viewAll.hidden=NO;
        view.frame=CGRectMake(0, 38+240, 320, 460-44-38);
    }
    else if(viewAll.hidden==NO){
        viewAll.hidden=YES;
        view.frame=CGRectMake(0, 38, 320, 460-44-38);
    }
    
    
}
-(void)defaultKinds:(UITapGestureRecognizer *)tap{
    
    if(deImg.image ==[UIImage imageNamed:@"List_tab_NO_right"])
    {
        deImg.image=[UIImage imageNamed:@"List_tab_YES"];
        
        
    }
    else if(deImg.image ==[UIImage imageNamed:@"List_tab_YES"]){
        deImg.image=[UIImage imageNamed:@"List_tab_NO_right"];
    }
    
    if(viewDef.hidden==YES){
        viewDef.hidden=NO;
        view.frame=CGRectMake(0, 38+240, 320, 460-44-38);
    }
    else if(viewDef.hidden==NO){
        viewDef.hidden=YES;
        view.frame=CGRectMake(0, 38, 320, 460-44-38);
    }
    
}
-(void)choose1:(UITapGestureRecognizer *)tap{
    
    defaultTitle.text=[array4 objectAtIndex:tap.view.tag-2000];
}
-(void)choose:(UITapGestureRecognizer *)tap{
    allTitle.text=[array2 objectAtIndex:tap.view.tag-1000];
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
