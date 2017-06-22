//
//  ZuijiaViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "ZuijiaViewController.h"
#import "ZuijiaDetailViewController.h"
#import "FMDatabase.h"
@interface ZuijiaViewController ()

@end

@implementation ZuijiaViewController

@synthesize path;

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
    
    [self.navigationController setNavigationBarHidden:NO];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    self.hidesBottomBarWhenPushed=YES;
}
-(void)viewDidAppear:(BOOL)animated{
    
    self.hidesBottomBarWhenPushed=YES;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"最佳体验";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    dataArray=[[NSMutableArray alloc]init];
    arrayId=[[NSMutableArray alloc]init];
  
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
    
    FMResultSet *set=[db executeQuery:@"select  * from listdo_guide_data_main where parentid='536042' order by orderid asc"];
    
    while ([set next]) {
    
        NSString *str1=[set objectForColumnName:@"title"];
        NSString *str2=[set objectForColumnName:@"dataid"];
        [dataArray addObject:str1];
        [arrayId addObject:str2];
    }
    
    [db close];
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Link_bg1"]];
    view.frame=CGRectMake(0, 0, 320, 90);
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 280, 50)];
    label.text=[dataArray objectAtIndex:indexPath.row];
    label.numberOfLines=0;
    label.backgroundColor=[UIColor clearColor];
    [view addSubview:label];
    
    UIImageView *vi=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    vi.frame=CGRectMake(300, 36, 13, 18) ;
    [view addSubview:vi];
    [cell.contentView addSubview:view];
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZuijiaDetailViewController *zui=[[ZuijiaDetailViewController alloc]init];
    zui.dataid=[[arrayId objectAtIndex:indexPath.row]integerValue];
    [self.navigationController pushViewController:zui animated:YES];
    [zui release];
    
    
    
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
