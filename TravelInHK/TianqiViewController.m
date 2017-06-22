//
//  TianqiViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "TianqiViewController.h"


@interface TianqiViewController ()

@end

@implementation TianqiViewController

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
    self.navigationItem.title=@"天气预报";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
       UIImageView *vi=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"daa25930864f5d897d84850afc30070f.jpg"]];
    vi.frame=CGRectMake(0, 0, 320, 460-44);
    [self.view addSubview:vi];
    
    UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(135, 20, 50, 50)];
    [vi addSubview:im];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80, 80, 200, 40)];
    label.backgroundColor=[UIColor clearColor];
    [vi addSubview:label];
    
    
    NSURL *URL =[NSURL URLWithString:@"http://www.weather.com.cn/data/cityinfo/101320101.html"];
    NSError *error;
    NSString *stringFromFileAtURL = [[NSString alloc]
                                     initWithContentsOfURL:URL
                                     encoding:NSUTF8StringEncoding
                                     error:&error];
    NSString *strTempL;
    NSString *strTempH;
    NSString *strWeather;
    NSString *fileName=@"晴.png";
    if(stringFromFileAtURL !=nil)
    {
        
    NSArray *strarray = [stringFromFileAtURL componentsSeparatedByString:@"\""];
        
        for(int i=0;i<strarray.count;i++)
        {
           
            NSString *str = [strarray objectAtIndex:i];
            if(YES == [str isEqualToString:@"temp1"])//最高温度
            {
                strTempH = [strarray objectAtIndex:i+2];
            }
            else if(YES == [str isEqualToString:@"temp2"])//最低温度
            {
                strTempL = [strarray objectAtIndex:i+2];
            }
            else if(YES == [str isEqualToString:@"weather"])//天气
            {
                strWeather = [strarray objectAtIndex:i+2];
            }
            
        }
        
        
        NSString *sweather = [[NSString alloc]initWithFormat:@"香港天气:%@\n%@~%@",strWeather,strTempL,strTempH];
        
        
        if(NSNotFound != [strWeather rangeOfString:@"晴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@",@"晴.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"多云"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"多云.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"阴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"阴.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雪"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"小雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雷"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雷雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雾"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雾.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"大雪"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"大雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"大雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"中雪"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"中雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"中雨"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"小雪"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"小雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"小雨"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雨加雪"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雨夹雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"阵雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雷阵雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雷阵雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"大雨转晴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨转晴.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"阴转晴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"阴转晴.png"];
        }
        
        if(sweather !=nil)
            label.text = sweather;
    }
    
    im.image = [UIImage imageNamed:fileName];

        
 
    
    
    
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
