//
//  YijianViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "YijianViewController.h"

@interface YijianViewController ()

@end

@implementation YijianViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=YES;
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
    self.navigationItem.title=@"意见反馈";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 20)];
    label1.text=@"欢迎您提出宝贵的意见和建议(反馈有奖品)";

    label1.textAlignment=NSTextAlignmentCenter;
    label1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label1];
    tf1=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 100)];
    tf1.delegate=self;
    tf1.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:tf1];
    
    
    tf2=[[UITextField alloc]initWithFrame:CGRectMake(10, 160, 300, 40)];
    tf2.placeholder=@"您的联系方式（E-Mail,QQ,手机号码）";
    tf2.borderStyle=UITextBorderStyleLine;
    tf2.delegate=self;
    [self.view addSubview:tf2];
    
    
    UIButton *b=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.frame=CGRectMake(110, 210, 100, 40);
    [b setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:b];
    [b addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for(UIView *v in [self.view subviews]){
        
        if ([v isKindOfClass:[UITextField class]]) {
            
            [v resignFirstResponder];
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
-(void)Submit:(UIButton *)button{

    if([tf1.text length]!=0 && [tf2.text length] !=0){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        tf1.text=@"";
        tf2.text=@"";
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请您填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
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
