//
//  HuobiViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "HuobiViewController.h"
#import "HttpDownload.h"
#import "HuobiItem.h"
@interface HuobiViewController ()

@end

@implementation HuobiViewController

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
    self.navigationItem.title=@"货币换算";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    
    array=[[NSMutableArray alloc]init];
     dataArray=[[NSMutableArray alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   // NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,250, 320, 20)];
    label.backgroundColor=[UIColor clearColor];
    label.text=[NSString stringWithFormat:@"更新时间：%@",[dateFormatter stringFromDate:[NSDate date]]];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    [dateFormatter release];
    UIImageView *im1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TimeZone_citybg"]];
    im1.frame=CGRectMake(5, 20, 140, 60);
    label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 140, 40)];
    label1.numberOfLines=0;
    label1.textAlignment=NSTextAlignmentCenter;
    label1.backgroundColor=[UIColor clearColor];
    label1.textColor=[UIColor whiteColor];
    label1.text=@"人民币";
    [im1 addSubview:label1];
    [self.view addSubview:im1];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
    im1.userInteractionEnabled=YES;
    [im1 addGestureRecognizer:tap1];
    
    UIImageView *im2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TimeZone_citybg"]];
    im2.frame=CGRectMake(5, 140, 140, 60);
    label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 140, 40)];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.numberOfLines=0;
    label2.text=@"人民币";
    label2.backgroundColor=[UIColor clearColor];
    label2.textColor=[UIColor whiteColor];
    [im2 addSubview:label2];
    [self.view addSubview:im1];
    [self.view addSubview:im2];
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
    im2.userInteractionEnabled=YES;
    [im2 addGestureRecognizer:tap2];
    
    
    tf1=[[UITextField alloc]initWithFrame:CGRectMake(150, 35, 150, 40)];
    tf1.borderStyle=UITextBorderStyleRoundedRect;
    
    tf1.delegate=self;
    [self.view addSubview:tf1];
    
    tf2=[[UITextField alloc]initWithFrame:CGRectMake(150, 155, 150, 40)];
    tf2.borderStyle=UITextBorderStyleRoundedRect;
    tf2.delegate=self;
    [self.view addSubview:tf2];
    
    [self loadData];
    
    
    
   

   
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    int x;
    int y;
    
    if(textField==tf1){
        NSLog(@"tf1");
        for(int i=0;i<[array count];i++){
            if([label1.text isEqualToString:[array objectAtIndex:i]]){
                x=i;
            }
            
        }
        for(int i=0;i<[array count];i++){
            if([label2.text isEqualToString:[array objectAtIndex:i]]){
                y=i;
            }
            
        }
        HuobiItem *item1=[dataArray objectAtIndex:x];
        float f1=[item1.price floatValue];
        
        HuobiItem *item2=[dataArray objectAtIndex:y];
        float f2=[item2.price floatValue];
        float result=[tf1.text floatValue] * f1/f2;
        
        tf2.text=[NSString stringWithFormat:@"%0.4f",result];
        
        
    }
   
    else if(textField==tf2){
        NSLog(@"tf2");
        for(int i=0;i<[array count];i++){
            if([label2.text isEqualToString:[array objectAtIndex:i]]){
                x=i;
            }
            
        }
        for(int i=0;i<[array count];i++){
            if([label1.text isEqualToString:[array objectAtIndex:i]]){
                y=i;
            }
            
        }
        HuobiItem *item1=[dataArray objectAtIndex:x];
        float f1=[item1.price floatValue];
        
        NSLog(@"f1 %f",f1);
        
        HuobiItem *item2=[dataArray objectAtIndex:y];
        float f2=[item2.price floatValue];
        NSLog(@"f2 %f",f2);
        float result=[tf2.text floatValue] * f1/f2;
        
        tf1.text=[NSString stringWithFormat:@"%0.4f",result];
        
        
    }

    
    
    return YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
   
    
    for(UIView *v in [self.view subviews]){
        if ([v isKindOfClass:[UITextField class]]) {
           
            [v resignFirstResponder];
        }
    }
}
-(void)loadData{
   NSString *path=[[NSBundle mainBundle]pathForResource:@"rate" ofType:@"txt"];
    HttpDownload *hd=[[HttpDownload alloc]init];
    
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    hd.type=2;
    [hd downloadFromUrl:path];
    
}
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        NSDictionary *dict1=[dict objectForKey:@"rate"];
        int i=0;
        for(i=0;i<37;i++){
            NSDictionary *dictItem=[dict1 objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        
            HuobiItem *item=[[HuobiItem alloc]init];
            item.name=[dictItem objectForKey:@"name"];
            [array addObject:item.name];
            item.logo=[dictItem objectForKey:@"logo"];
           
            item.price=[dictItem objectForKey:@"price"];
          
            item.code=[dictItem objectForKey:@"code"];
            
            [dataArray addObject:item];
        }
    }
   
    
}
-(void)tap1:(UITapGestureRecognizer *)tap{
    tf1.text=@"";
    tf2.text=@"";

    sheet1=[[UIActionSheet alloc]initWithTitle:@"请选择币种" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],[array objectAtIndex:4],[array objectAtIndex:5],[array objectAtIndex:6],[array objectAtIndex:7],[array objectAtIndex:8],[array objectAtIndex:9],[array objectAtIndex:10],[array objectAtIndex:11],[array objectAtIndex:12],[array objectAtIndex:13],[array objectAtIndex:14],[array objectAtIndex:15],[array objectAtIndex:16],[array objectAtIndex:17],[array objectAtIndex:18],[array objectAtIndex:19],[array objectAtIndex:20],[array objectAtIndex:21],[array objectAtIndex:22],[array objectAtIndex:23],[array objectAtIndex:24],[array objectAtIndex:25],[array objectAtIndex:26],[array objectAtIndex:27],[array objectAtIndex:28],[array objectAtIndex:29],[array objectAtIndex:30],[array objectAtIndex:31],[array objectAtIndex:32],[array objectAtIndex:33],[array objectAtIndex:34],[array objectAtIndex:35],[array objectAtIndex:36],nil];
    sheet1.backgroundColor=[UIColor blueColor];
     [sheet1 showInView:self.view];
}
-(void)tap2:(UITapGestureRecognizer *)tap{
    tf1.text=@"";
    tf2.text=@"";
    sheet2=[[UIActionSheet alloc]initWithTitle:@"请选择币种" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],[array objectAtIndex:4],[array objectAtIndex:5],[array objectAtIndex:6],[array objectAtIndex:7],[array objectAtIndex:8],[array objectAtIndex:9],[array objectAtIndex:10],[array objectAtIndex:11],[array objectAtIndex:12],[array objectAtIndex:13],[array objectAtIndex:14],[array objectAtIndex:15],[array objectAtIndex:16],[array objectAtIndex:17],[array objectAtIndex:18],[array objectAtIndex:19],[array objectAtIndex:20],[array objectAtIndex:21],[array objectAtIndex:22],[array objectAtIndex:23],[array objectAtIndex:24],[array objectAtIndex:25],[array objectAtIndex:26],[array objectAtIndex:27],[array objectAtIndex:28],[array objectAtIndex:29],[array objectAtIndex:30],[array objectAtIndex:31],[array objectAtIndex:32],[array objectAtIndex:33],[array objectAtIndex:34],[array objectAtIndex:35],[array objectAtIndex:36],nil];
    sheet2.backgroundColor=[UIColor blueColor];
    [sheet2 showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
  
    if(actionSheet==sheet1){
        label1.text=[array objectAtIndex:buttonIndex];
    }
    else{
        label2.text=[array objectAtIndex:buttonIndex];
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
