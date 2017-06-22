//
//  NearbyViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "NearbyViewController.h"
#import "NearByDetailViewController.h"
@interface NearbyViewController ()

@end

@implementation NearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"nearby_icon_on"] withFinishedUnselectedImage:[UIImage imageNamed:@"nearby_icon"]];
    
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
    self.navigationItem.title=@"附近";
    
    myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 50*5) style:UITableViewStylePlain];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    dataArray=[[NSMutableArray alloc]init];
    
    NSString *str=[[NSString alloc]initWithString:@"附近有0个"];
    NSArray *array=[NSArray arrayWithObjects:@"景点",@"酒店",@"美食",@"购物",@"娱乐",nil];
    NSArray *aray1=[NSArray arrayWithObjects:@"LV_nearby_icon_scenic", @"LV_nearby_icon_hotel", @"LV_nearby_icon_food", @"LV_nearby_icon_shopping", @"LV_nearby_icon_relax", nil];
    for(int i=0;i<[array count];i++){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        UIImageView *im1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[aray1 objectAtIndex:i]]];
        im1.frame=CGRectMake(10, 5, 35, 40);
        [view addSubview:im1];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(55, 15, 40, 20)];
        label.text=[array objectAtIndex:i];
        label.backgroundColor=[UIColor clearColor];
        [view addSubview:label];
        
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(225, 15, 80, 20)];
        la.text=str;
        la.textColor=[UIColor grayColor];
        la.backgroundColor=[UIColor clearColor];
        la.font=[UIFont systemFontOfSize:14];
        [view addSubview:la];
        
        
        UIImageView *im2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
        im2.frame=CGRectMake(300, 20, 10, 10);
        [view addSubview:im2];
        [dataArray addObject:view];
    }
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell.contentView addSubview:[dataArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NearByDetailViewController *ne=[[NearByDetailViewController alloc]init];
    ne.numid=indexPath.row;
    [self.navigationController pushViewController:ne animated:YES];
    [ne release];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
