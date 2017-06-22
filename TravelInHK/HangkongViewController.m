//
//  HangkongViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "HangkongViewController.h"

@interface HangkongViewController ()

@end

@implementation HangkongViewController

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
    self.navigationItem.title=@"航空电话";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStyleGrouped];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    dataArray=[[NSMutableArray alloc]init];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"Airline" ofType:@"txt"];
    NSString *content=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array=[content componentsSeparatedByString:@"\n"];
    for(int i=1;i<[array count];i++){
      
        NSArray *array1= [[array objectAtIndex:i]componentsSeparatedByString:@"||"];
        if([array1 count]>1){
        NSMutableString *string=[[NSMutableString alloc]initWithString: [array1 objectAtIndex:0]];
        [string appendString:@":"];
        [string appendString:[array1 objectAtIndex:1]];
        [dataArray addObject:string];
        
        }
        
    }

    
    
               
               
               
               
               
               
               
               
               
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"航空电话"];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text=[dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str1=[[[dataArray objectAtIndex:indexPath.row]componentsSeparatedByString:@":"]objectAtIndex:1];
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"拨打电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:str1 otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        NSLog(@"打电话");
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
