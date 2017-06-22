//
//  EntViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "EntViewController.h"
#import "MyAnnotation.h"
#import "FMDatabase.h"
#import "RelaxTableViewController.h"
#import "ImgItem.h"
#import "ItemCell.h"
@interface EntViewController ()

@end

@implementation EntViewController
@synthesize path;
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
-(void)createTableFooter{
    myTableview.tableFooterView=nil;
    if([arrayTotal isEqual: dataArray]==1){
        
    }
    else if ([dataArray isEqual:jiuba ]){
        
    }
    else if ([dataArray isEqual:chaguan ]){
        
    }
    else if ([dataArray isEqual:dianyingyuan ]){
        
    }
    else if ([dataArray isEqual:yedian ]){
        
    }
    else if ([dataArray isEqual:kafeiguan]){
        
    }
    else if ([dataArray isEqual:juchang]){
        
    }
    else if ([dataArray isEqual:ktv]){
        
    }
    
    
    else if([dataArray isEqual:pingfen]){
        
    }
    else if([dataArray isEqual:juli]){
        
    }
    else{
        UIView *tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        tableFooterView.backgroundColor=[UIColor grayColor];
        UILabel *loadMoreText=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [loadMoreText setCenter:tableFooterView.center];
        [loadMoreText setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [loadMoreText setText:@"上拉显示更多数据"];
        loadMoreText.backgroundColor=[UIColor clearColor];
        [tableFooterView addSubview:loadMoreText];
        myTableview.tableFooterView=tableFooterView;
    }
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"娱乐";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    img1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-map"]];
    img1.userInteractionEnabled=YES;
    UIBarButtonItem *button1=[[UIBarButtonItem alloc]initWithCustomView:img1];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(huan:)];
    [img1 addGestureRecognizer:tap1];
    
    self.navigationItem.rightBarButtonItem=button1;
    all=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"List_tab_NO_right"]];
    all.frame=CGRectMake(0, 0, 160, 38);
    all.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allKinds:)];
    tap3.numberOfTapsRequired=1;
    tap3.numberOfTouchesRequired=1;
    [all addGestureRecognizer:tap3];
    [self.view addSubview:all];
    
    allTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 9, 120, 20)];
    allTitle.text=@"全部类型";
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
    defaultTitle.text=@"默认类型";
    defaultTitle.backgroundColor=[UIColor clearColor];
    [deImg addSubview:defaultTitle];
    
    
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 38, 320, 460-44-38)];
    [self.view addSubview:view];
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-38)];
    
    
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-38)];
    [view addSubview:v2];
    myTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-38) style:UITableViewStylePlain];
    myTableview.delegate=self;
    myTableview.dataSource=self;
    [v1 addSubview:myTableview];
    [self createTableFooter];
    [view addSubview:v1];
    dataArray=[[NSMutableArray alloc]init];
    arrayTotal=[[NSMutableArray alloc]init];

    jiuba=[[NSMutableArray alloc]init];
   chaguan=[[NSMutableArray alloc]init];
    dianyingyuan=[[NSMutableArray alloc]init];
    yedian=[[NSMutableArray alloc]init];
    kafeiguan=[[NSMutableArray alloc]init];
    juchang=[[NSMutableArray alloc]init];
    ktv=[[NSMutableArray alloc]init];
    pingfen=[[NSMutableArray alloc]init];
    juli=[[NSMutableArray alloc]init];
    zongshuzu=[[NSMutableArray alloc]initWithObjects:arrayTotal,jiuba,chaguan,dianyingyuan,yedian,kafeiguan,juchang,ktv,pingfen,juli,nil];
    totalMap=[[NSMutableArray alloc]init];
    systemMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-38)];
    systemMapView.delegate=self;
    CLLocationCoordinate2D lc2d=CLLocationCoordinate2DMake(22.323,114.168);
    
    MKCoordinateSpan span=MKCoordinateSpanMake(0.5, 0.5);
    MKCoordinateRegion region=MKCoordinateRegionMake(lc2d, span);
    [systemMapView setRegion:region];
    
    systemMapView.showsUserLocation=YES;
    systemMapView.mapType=MKMapTypeStandard;
    [v2 addSubview:systemMapView];
    
    
    viewAll=[[UIView alloc]initWithFrame:CGRectMake(0, 38, 320, 240)];
    viewAll.hidden=YES;
    viewAll.userInteractionEnabled=YES;
    viewAll.backgroundColor=[UIColor blackColor];
    [self.view addSubview:viewAll];
    
    NSArray *array1=[NSArray arrayWithObjects:@"LV_Class_relax_",@"LV_Class_relax_jiuba",@"LV_Class_relax_chaguan",@"LV_Class_relax_dianyingyuan",@"LV_Class_relax_yedian",@"LV_Class_relax_cafeiguan",@"LV_Class_relax_juchang",@"LV_Class_relax_ktv",nil];
    array2=[[NSArray alloc]initWithObjects:@"全部类型",@"酒吧",@"茶馆",@"电影院",@"夜店",@"咖啡馆",@"剧场",@"KTV",nil];
    
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

    NSArray *array3=[NSArray arrayWithObjects:@"LV_Class_order_",@"LV_Class_order_pingfen",@"LV_Class_order_juli",nil];
    array4=[[NSArray alloc]initWithObjects:@"默认排序",@"评分排序",@"距离排序",nil];
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

     NSArray *arraySelect=[NSArray arrayWithObjects:@"select * from listdo_relax_main",@"select * from listdo_relax_main where category='酒吧'",@"select * from listdo_relax_main where category='茶馆'",@"select * from listdo_relax_main where category='电影院'",@"select * from listdo_relax_main where category='夜店'",@"select * from listdo_relax_main where category='咖啡馆'",@"select * from listdo_relax_main where category='剧场'",@"select * from listdo_relax_main where category='KTV'",nil];
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
    
    for(int i=0;i<[arraySelect count];i++){
        FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"%@",[arraySelect objectAtIndex:i]]];
        while ([set next]) {
            ItemCell *cell=[[ItemCell alloc]init];
            cell.scenicname=[set objectForColumnName:@"scenicname"];
            cell.logo=[[[set objectForColumnName:@"logo"]componentsSeparatedByString:@"/"]objectAtIndex:1];
            cell.content=[set objectForColumnName:@"content"];
            cell.score=[[set objectForColumnName:@"score"]floatValue];
            cell.pricesummary=[set objectForColumnName:@"price_summary"];
            cell.scenicid=[set objectForColumnName:@"scenicid"];
            cell.aword=[set objectForColumnName:@"aword"];
            cell.jing=[set objectForColumnName:@"map_lat"];
            cell.wei=[set objectForColumnName:@"map_lng"];
            [[zongshuzu objectAtIndex:i] addObject:cell];
            
        }
        
        
        
        
    }
    
    [db close];
    ditu=[[NSMutableArray alloc]init];
    for(int i=0;i<20;i++){
        [dataArray addObject:[arrayTotal objectAtIndex:i]];
        ItemCell *cell=[dataArray objectAtIndex:i];
        MyAnnotation *annotation1=[[MyAnnotation alloc]initWithTitle:cell.scenicname subtitle:cell.aword location:CLLocationCoordinate2DMake([cell.jing floatValue],[cell.wei floatValue])];
        [systemMapView addAnnotation:annotation1];
        [totalMap addObject:annotation1];
    }
    
    
    

    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!_loadingMore && scrollView.contentOffset.y>(scrollView.contentSize.height-scrollView.frame.size.height)){
        [self loadDataBegin];
    }
}
-(void)loadDataBegin{
    if(_loadingMore==NO){
        _loadingMore=YES;
        UIActivityIndicatorView *tableFooterActivityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(75, 10, 20, 20)];
        [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [tableFooterActivityIndicator startAnimating];
        [myTableview.tableFooterView addSubview:tableFooterActivityIndicator];
        [self loadDataing];
    }
}
-(void)loadDataing{
    int x=0;
    int y=[dataArray count];
    for(x=0;x<20;x++){
        if((x+y)<[arrayTotal count])
        {
            [dataArray addObject:[arrayTotal objectAtIndex:x+y]];
        }
    }
    [myTableview reloadData];
    dataNumber=[dataArray count];
    [systemMapView removeAnnotations:totalMap];
    [totalMap removeAllObjects];
    [ditu removeAllObjects];
    for(int i=0;i<[dataArray count];i++){
        ItemCell *cell=[dataArray objectAtIndex:i];
        MyAnnotation *annotation1=[[MyAnnotation alloc]initWithTitle:cell.scenicname subtitle:cell.aword location:CLLocationCoordinate2DMake([cell.jing floatValue],[cell.wei floatValue])];
        [systemMapView addAnnotation:annotation1];
        [totalMap addObject:annotation1];
    }
    
    
    [self loadDataEnd];
    
}
-(void)loadDataEnd{
    _loadingMore=NO;
    [self createTableFooter];
    
    
    
}
-(void)choose1:(UITapGestureRecognizer *)tap{
    
    defaultTitle.text=[array4 objectAtIndex:tap.view.tag-2000];
    [dataArray removeAllObjects];
    if(tap.view.tag==2000){
        [dataArray addObjectsFromArray:arrayTotal];
        [myTableview reloadData];
        [self createTableFooter];
        _loadingMore=NO;
    }else{
        [dataArray addObjectsFromArray:[zongshuzu objectAtIndex:(tap.view.tag-2001+[array2 count])]];
        [myTableview reloadData];
        [self createTableFooter];
        
        _loadingMore=NO;
    }
    
    [systemMapView removeAnnotations:totalMap];
    [totalMap removeAllObjects];
    [ditu removeAllObjects];
    for(int i=0;i<[dataArray count];i++){
        ItemCell *cell=[dataArray objectAtIndex:i];
        MyAnnotation *annotation1=[[MyAnnotation alloc]initWithTitle:cell.scenicname subtitle:cell.aword location:CLLocationCoordinate2DMake([cell.jing floatValue],[cell.wei floatValue])];
        [systemMapView addAnnotation:annotation1];
        [totalMap addObject:annotation1];
    }
    
}
-(void)choose:(UITapGestureRecognizer *)tap{
    allTitle.text=[array2 objectAtIndex:tap.view.tag-1000];
    [dataArray removeAllObjects];
    
    if(tap.view.tag==1000){
        for(int i=0;i<20;i++){
            [dataArray addObject:[arrayTotal objectAtIndex:i]];
            _loadingMore=NO;
        }
        
    }
    else{
        [dataArray addObjectsFromArray:[zongshuzu objectAtIndex:tap.view.tag-1000]];
        _loadingMore=YES;
    }
    [myTableview reloadData];
    [self createTableFooter];
    
    [systemMapView removeAnnotations:totalMap];
    [totalMap removeAllObjects];
    [ditu removeAllObjects];
    for(int i=0;i<[dataArray count];i++){
        ItemCell *cell=[dataArray objectAtIndex:i];
        MyAnnotation *annotation1=[[MyAnnotation alloc]initWithTitle:cell.scenicname subtitle:cell.aword location:CLLocationCoordinate2DMake([cell.jing floatValue],[cell.wei floatValue])];
        [systemMapView addAnnotation:annotation1];
        [totalMap addObject:annotation1];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    ItemCell *item=[dataArray objectAtIndex:indexPath.row];
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 90)];
    UIImageView *img3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",item.logo]]];
    
    UIImageView *img2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Link_bg1"]];
    
    img2.frame=CGRectMake(0, 0, 320, 90);
    [backView addSubview:img2];
    
    img3.frame=CGRectMake(10, 10, 80, 70);
    [backView addSubview:img3];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 200, 20)];
    label.text=item.scenicname;
    label.backgroundColor=[UIColor clearColor];
    [backView addSubview:label];
    
    UIImageView *img4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"star_%d",(int)item.score]]];
    img4.frame=CGRectMake(100, 30, 69, 13);
    [backView addSubview:img4];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(100, 47, 210, 40)];
    la1.text=item.content;
    la1.font=[UIFont systemFontOfSize:14];
    la1.backgroundColor=[UIColor clearColor];
    la1.numberOfLines=0;
    [backView addSubview:la1];
    
    UILabel *la2=[[UILabel alloc]initWithFrame:CGRectMake(260, 25, 60, 20)];
    la2.text=item.pricesummary;
    la2.font=[UIFont systemFontOfSize:14];
    la2.backgroundColor=[UIColor clearColor];
    [backView addSubview:la2];
    
    [cell.contentView addSubview:backView];
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemCell *cell=[dataArray objectAtIndex:indexPath.row];
    RelaxTableViewController *ce=[[RelaxTableViewController alloc]init];
    ce.linkid=[cell.scenicid integerValue];
    [self.navigationController pushViewController:ce animated:YES];
    [ce release];
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *annotationName=@"annotationName";
    
    MKAnnotationView *view1=[self->systemMapView dequeueReusableAnnotationViewWithIdentifier:annotationName];
    
    if(!view1){
        
        view1=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationName];
        view1.canShowCallout=YES;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view1.rightCalloutAccessoryView=button;
        ImgItem *item=[[ImgItem alloc]initWithFrame:CGRectMake(1, 1, 1, 1)];
        item.backgroundColor=[UIColor clearColor];
        [button addSubview:item];
        item.annotion=annotation;
        [button addTarget:self action:@selector(buttonMap:) forControlEvents:UIControlEventTouchUpInside];
        view1.image=[UIImage imageNamed:@"map_spot_s1"];
        item.view=view1;
        
        
        
    }
    [ditu addObject:view1];
    return view1;
    
}
-(void)buttonMap:(UIButton *)button{
    
    
    
    
    ImgItem *vi=(ImgItem *)[[button subviews]objectAtIndex:1];
    
    MKAnnotationView *view1=vi.view;
    int y;
    for(int i=0;i<[ditu count];i++){
        if([[ditu objectAtIndex:i]isEqual:view1]==1){
            y=i;
            
            
        }
    }
    
    
    ItemCell *item=[dataArray objectAtIndex:y];
    RelaxTableViewController *ce=[[RelaxTableViewController alloc]init];
    ce.linkid=[item.scenicid integerValue];
    
    [self.navigationController pushViewController:ce animated:YES];
    [ce release];
    
    
    
    
    
    
}
-(void)huan:(UIButton *)button{
    
    [UIView beginAnimations:@"animationID" context:nil];//开始一个动画块，第一个参数为动画块标识
    
    [UIView setAnimationDuration:0.5f];//设置动画的持续时间
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//设置动画块中的动画属性变化的曲线，此方法必须在beginAnimations方法和commitAnimations，默认即为UIViewAnimationCurveEaseInOut效果。详细请参见UIViewAnimationCurve
    
    [UIView setAnimationRepeatAutoreverses:NO];//设置是否自动反转当前的动画效果
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:YES];//设置过渡的动画效果，此处第一个参数可使用上面5种动画效果
    
    [view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];//页面翻转
    if(img1.image ==[UIImage imageNamed:@"header-map"])
    {
        img1.image=[UIImage imageNamed:@"header-list"];
        
        
    }
    else if(img1.image ==[UIImage imageNamed:@"header-list"]){
        img1.image=[UIImage imageNamed:@"header-map"];
    }
    
    
    [UIView commitAnimations];
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
