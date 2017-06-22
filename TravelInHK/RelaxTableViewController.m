//
//  RelaxTableViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "RelaxTableViewController.h"
#import "FMDatabase.h"
#import "Relax1ViewController.h"
#import "Relax2ViewController.h"
@interface RelaxTableViewController ()

@end

@implementation RelaxTableViewController

@synthesize linkid,path,linktype,path1;
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
    
    view99=[[UIImageView alloc]init];
    view99.frame=CGRectMake(10, 160, 30, 30);
    
    self.path1=[[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"news.db"];
    FMDatabase *db1=[FMDatabase databaseWithPath:path1];
    BOOL res=[db1 open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
    int flag=0;
    FMResultSet *set=[db1 executeQuery:@"select * from FVRT"];
    while ([set next]) {
        NSString *str=[set objectForColumnName:@"id"];
        if([str integerValue]==linkid){
            view99.image=[UIImage imageNamed:@"favorite_botton_on"];
            flag=1;
        }
    }
   [db1 close];
    if(flag==0){
        view99.image=[UIImage imageNamed:@"favorite_botton_off"];
    }
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
	dataArray=[[NSMutableArray alloc]init];
    NSMutableString *strTi=[[NSMutableString alloc]init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    myTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStyleGrouped];
    myTableview.delegate=self;
    myTableview.dataSource=self;
    [self.view addSubview:myTableview];
    
    strImg=[[NSMutableString alloc]init];
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
    
    
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_relax_main where scenicid='%d'",linkid]];
    
    NSMutableString *awoard=[[NSMutableString alloc]init];//评价
    
    
    
    NSMutableString *open=[[NSMutableString alloc]init];//营业时间
    
    
    NSMutableString *telephone=[[NSMutableString alloc]init];//电话
    
    NSMutableString *address=[[NSMutableString alloc]init];//地址
    
    NSMutableString *content=[[NSMutableString alloc]init];//简介
    NSMutableString *arrival_bus=[[NSMutableString alloc]init];//交通信息公交
    NSMutableString *arrival_rail=[[NSMutableString alloc]init];//交通信息地铁
    price_details=[[NSMutableString alloc]init];
    while ([set next]) {
        strTi=[set objectForColumnName:@"scenicname"];
        
        open=[set objectForColumnName:@"open"];//营业时间
        arrival_bus=[set objectForColumnName:@"arrival_bus"];//公交
        arrival_rail=[set objectForColumnName:@"arrival_rail"];//地铁
        address=[set objectForColumnName:@"address"];//地址
        telephone=[set objectForColumnName:@"telephone"];//电话
        content=[set objectForColumnName:@"content"];//简介
        awoard=[set objectForColumnName:@"aword"];//评价
        
        
    }
    [db close];
    
    self.navigationItem.title=strTi;
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 80)];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 280, 20)];
    label1.text=@"概况：";
    label1.backgroundColor=[UIColor clearColor];
    [view addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 200, 20)];
    label2.text=[NSString stringWithFormat:@"营业时间：%@",open];
    label2.textColor=[UIColor grayColor];
    label2.font=[UIFont systemFontOfSize:14];
    label2.backgroundColor=[UIColor clearColor];
    [view addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 200, 20)];
    label3.textColor=[UIColor grayColor];
    label3.font=[UIFont systemFontOfSize:14];
    if([arrival_bus length]!=0){
        label3.text=[NSString stringWithFormat:@"交通信息：%@",arrival_bus ];
        [view addSubview:label3];}
    else{
        label3.text=[NSString stringWithFormat:@"交通信息：%@",arrival_rail];
        [view addSubview:label3];
    }
    
    UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    im.frame=CGRectMake(260, 31, 13, 18);
    [view addSubview:im];
    [dataArray addObject:view];
    
    
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *im4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Detail_map_icon"]];
    im4.frame=CGRectMake(10, 15, 20, 20);
    [view3 addSubview:im4];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 240, 40)];
    label5.numberOfLines=0;
    label5.text=address;
    label5.backgroundColor=[UIColor clearColor];
    label5.font=[UIFont systemFontOfSize:14];
    [view3 addSubview:label5];
    
    [ dataArray addObject:view3];
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *im5=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Detail_phone_icon"]];
    im5.frame=CGRectMake(10, 15, 20, 20);
    [view4 addSubview:im5];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 240, 30)];
    label6.backgroundColor=[UIColor clearColor];
    label6.font=[UIFont systemFontOfSize:14];
    if([telephone length]==0){
        label6.text=@"暂无电话";
        [view4 addSubview:label6];
        [ dataArray addObject:view4];
        
    }
    else{
        label6.text=telephone;
        [view4 addSubview:label6];
        [ dataArray addObject:view4];
        
    }
    
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 120)];
    UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    label7.backgroundColor=[UIColor clearColor];
    label7.text=@"简介：";
    [view5 addSubview:label7];
    UILabel *label8=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 230, 80)];
    label8.text=content;
    label8.numberOfLines=0;
    label8.font=[UIFont systemFontOfSize:14];
    label8.backgroundColor=[UIColor clearColor];
    [view5 addSubview:label8];
    UIImageView *im11=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
    im11.frame=CGRectMake(260,40, 13, 18);
    [view5 addSubview:im11];
    [ dataArray addObject:view5];
    
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 80)];
    UILabel *label9= [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    label9.text=@"旅人评价 ：";
    UILabel *label10=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 280, 50)];
    label10.text=awoard;
    label10.numberOfLines=0;
    label10.textColor=[UIColor brownColor];
    label10.backgroundColor=[UIColor clearColor];
    label10.font=[UIFont systemFontOfSize:14];
    [view6 addSubview:label10];
    [view6 addSubview:label9];
    
    [ dataArray addObject:view6];
    
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    [ dataArray addObject:view6];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            return 80.0f;
        }
        else {
            return 50.0f;
        }
    }
    else if(indexPath.section==1){
        return 120.0f;
    }
    return 80.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 200;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section==0){
        self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
        FMDatabase *db=[FMDatabase databaseWithPath:path];
        
        BOOL res=[db open];
        if(res==NO){
            NSLog(@"打开失败");
            return nil;
        }
        
        FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_relax_main where scenicid='%d'",linkid]];
        while ([set next]) {
            strImg=[[[set objectForColumnName:@"logo"]componentsSeparatedByString:@"/"]objectAtIndex:1];
            
        }
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
        
        UIImageView *view2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:strImg]];
        view2.frame=CGRectMake(0, 0, 320, 200);
        [view1 addSubview:view2];
        [view2 release];
        
        
       
        [view2 addSubview:view99];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DataInorOut:)];
        [view99 addGestureRecognizer:tap];
        view99.userInteractionEnabled=YES;
        view2.userInteractionEnabled=YES;
        view1.userInteractionEnabled=YES;
        return view1;
    }
    else{
        return nil;
    }
}

-(void)DataInorOut:(UITapGestureRecognizer *)tap{
    UIImageView *im=(UIImageView *)tap.view;
    
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"news.db"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        
    }
    
    if(im.image==[UIImage imageNamed:@"favorite_botton_off"]){
        im.image=[UIImage imageNamed:@"favorite_botton_on"];
        
        res=[db executeUpdate:[NSString stringWithFormat: @"INSERT INTO FVRT (id,title) VALUES (%d,'listdo_relax_main')",linkid]];
        
        if(res==NO){
            
            NSLog(@"失败%@",[db lastErrorMessage]);
            
        }
        else{
            NSLog(@"成功");
        }
        
    }
    else{
        im.image=[UIImage imageNamed:@"favorite_botton_off"];
        
        NSString *sql=[NSString stringWithFormat:@" DELETE FROM FVRT WHERE id = '%d'",linkid];
        
        res= [db executeUpdate:sql];
        if(res==NO){
            
            NSLog(@"失败%@",[db lastErrorMessage]);
            
        }
        else{
            NSLog(@"成功");
        }
        
    }
    
    [db close];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell.contentView addSubview:[dataArray objectAtIndex:(indexPath.section * 3 + indexPath.row)]];
    return cell;
}

-(void)clicked:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            Relax1ViewController *ce=[[Relax1ViewController alloc]init];
            ce.scenicid=linkid;
            [self.navigationController pushViewController:ce animated:YES];
            [ce release];
        }
    }
    if(indexPath.section==1){
        Relax2ViewController *ce=[[Relax2ViewController alloc]init];
        ce.scenicid=linkid;
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
