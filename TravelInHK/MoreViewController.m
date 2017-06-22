//
//  MoreViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "MoreViewController.h"
#import "BanquanxinxiViewController.h"
#import "FuwutiaokuanViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"more_icon_on"] withFinishedUnselectedImage:[UIImage imageNamed:@"more_icon"]];
        
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
    self.navigationItem.title=@"更多";
    myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStyleGrouped];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    myTableView.backgroundColor=[UIColor whiteColor];
    
    dataArray=[[NSMutableArray alloc]init];
     
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 200, 20)];
        la1.text=@"版权信息";
    la1.backgroundColor=[UIColor clearColor];
    [v1 addSubview:la1];
    
    UIImageView *im1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    im1.frame=CGRectMake(260, 15, 10, 10);
    [v1 addSubview:im1];
        [dataArray addObject:v1];
    [dataArray addObject:v1];
    [dataArray addObject:v1];
    
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
    UILabel *la2=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 200, 20)];
    la2.text=@"服务条款";
    la2.backgroundColor=[UIColor clearColor];
    [v2 addSubview:la2];
    
    UIImageView *im2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    im2.frame=CGRectMake(260, 15, 10, 10);
    [v2 addSubview:im2];
    [dataArray addObject:v2];

    
    NSArray *ar1=[NSArray arrayWithObjects:@"8",@"9",@"10",@"11",@"12",@"14",@"15",@"17",@"19", nil];
    NSArray *ar2=[NSArray arrayWithObjects:@"悉尼",@"成都", @"上海", @"广州", @"伦敦", @"杭州", @"青岛", @"三亚", @"北京",  nil];
    UIView *v3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    for (int i=0; i<[ar1 count]; i++) {
        UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[ar1 objectAtIndex:i]]];
        img.frame=CGRectMake(20+(43+57)*(i%3), 10+(43+57)*(i/3), 57, 57);
        [v3 addSubview:img];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10+(43+57)*(i%3), 60+10 +(43+57)*(i/3), 80, 20)];
        label.text=[ar2 objectAtIndex:i];
        label.font=[UIFont systemFontOfSize:14];
        label.backgroundColor=[UIColor clearColor];
        label.textAlignment=NSTextAlignmentCenter;
        [v3 addSubview:label];
    }
    [dataArray addObject:v3];
    [dataArray addObject:v3];
    
    UIView *v4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    
    UILabel *la3=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 40)];
    la3.backgroundColor=[UIColor clearColor];
    la3.text=@"网址:www.lvren.com";
    [v4 addSubview:la3];
    [dataArray addObject:v4];
  
     UIView *v5=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    UILabel *la4=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 40)];
    la4.backgroundColor=[UIColor clearColor];
    [v5 addSubview:la4];
    la4.text=@"电话:010-58698341";
    [dataArray addObject:v5];

    UILabel *la5=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    la5.backgroundColor=[UIColor clearColor];
    la5.text=@"欢迎各类旅游商务合作";
    la5.textAlignment=NSTextAlignmentCenter;
    [dataArray addObject:la5];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }
    else if (section==1){
        return 2;
    }
    else if(section==2){
        return 1;
    }
    else 
        return 3;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section==3){
        
        return [NSString stringWithFormat:@"WWW.LVREN.COM"];
        
    }
    return nil;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==1){
        return [NSString stringWithFormat:@"关于"];
    }
    else if(section==2){
        return [NSString stringWithFormat:@"推荐应用"];
    }
    else if(section==3){
        return [NSString stringWithFormat:@"联系我们"];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 0;
    }
   else if(indexPath.section==1){
        return 40.0f;
    }
    else if(indexPath.section==2){
        return 300.0f;
    }
    else
        return 40.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section==0){
        
        return 90.0f;
    }
    else
        return 30.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 90)];
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
        im.frame=CGRectMake(20, 20, 57, 57);
        UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 200, 20)];
        la1.backgroundColor=[UIColor clearColor];
        la1.text=@"香港旅游指南V1.0";
        [view addSubview:la1];
        UILabel *la2=[[UILabel alloc]initWithFrame:CGRectMake(90, 44, 200, 20)];
        la2.backgroundColor=[UIColor clearColor];
        la2.text=@"旅人全球旅游指南系列";
        la2.font=[UIFont systemFontOfSize:14];
        la2.textColor=[UIColor grayColor];
        [view addSubview:la2];
        UILabel *la3=[[UILabel alloc]initWithFrame:CGRectMake(90, 65, 200, 20)];
        la3.backgroundColor=[UIColor clearColor];
        la3.textColor=[UIColor grayColor];
        la3.font=[UIFont systemFontOfSize:14];
        la3.text=@"©2013旅人网";
        [view addSubview:la3];
        [view addSubview:im];
        return view;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    [cell.contentView addSubview:[dataArray objectAtIndex:(indexPath.section *2+indexPath.row)]];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        if(indexPath.row==0){
            BanquanxinxiViewController *ba=[[BanquanxinxiViewController alloc]init];
            [self.navigationController pushViewController:ba animated:YES];
            [ba release];
        }
        else{
            FuwutiaokuanViewController *fu=[[FuwutiaokuanViewController alloc]init];
            [self.navigationController pushViewController:fu animated:YES];
            [fu release];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
