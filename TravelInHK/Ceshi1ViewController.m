//
//  Ceshi1ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-9.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Ceshi1ViewController.h"
#import "Ceshi2ViewController.h"
#import "MyAnnotation.h"
#import "FMDatabase.h"
@interface Ceshi1ViewController ()

@end

@implementation Ceshi1ViewController
@synthesize planid,descri,titleName,path;
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
    //[self.navigationController setToolbarHidden:NO];
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
    
    arrayLinkId=[[NSMutableArray alloc]init];
    arrayJ=[[NSMutableArray alloc]init];
    arrayW=[[NSMutableArray alloc]init];
    arrayImg=[[NSMutableArray alloc]init];
    tianshu=[[NSMutableArray alloc]init];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"线路详情";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
   
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_travel_activities where planid='%@' ORDER BY dayid ASC",planid]];
  arrayId=[[NSMutableArray alloc]init];
    while([set next]){
    NSString  * datastr=[set objectForColumnName:@"dayid"];
        int flag=0;
        for(int i=0;i<[arrayId count] ;i++){
            if([datastr isEqual:[arrayId objectAtIndex:i]]==1){
                flag=1;
            }
        }
             if(flag==0){
        [arrayId addObject:datastr];//共有几天；
        }
    }
    NSMutableArray *arrayDescription=[[NSMutableArray alloc]init];
    NSMutableArray *arrayZ=[[NSMutableArray alloc]init];
    NSMutableArray *array1=[[NSMutableArray alloc]init];
    NSString *string1=[NSString string];
    
    for(int j=0;j<[arrayId count];j++){
    
    FMResultSet *set1=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_travel_activities where dayid='%@' ORDER BY orderid ASC",[arrayId objectAtIndex:j]]];
        
        NSMutableArray *array2=[[NSMutableArray alloc]init];
        while ([set1 next]) {
            NSString *string4=[set1 objectForColumnName:@"type"];
            if([string4 isEqualToString:@"other"]==1){
                
            }else{
            string1=[set1 objectForColumnName:@"title"];
            NSString *string2=[set1 objectForColumnName:@"map_lat"];
            [arrayJ addObject:string2];
            NSString *string3=[set1 objectForColumnName:@"map_lng"];
            [arrayW addObject:string3];
            NSString *str4=[set1 objectForColumnName:@"description"];
            [arrayDescription addObject:str4];
            NSString *str5=[set1 objectForColumnName:@"linktype"];
            if([str5 isEqualToString:@"scenic"]){
                [arrayImg addObject:@"map_spot_s1"];
            }
            else if([str5 isEqualToString:@"restaurant"]){
                [arrayImg addObject:@"map_eat_s1"];
            }
            else if([str5 isEqualToString:@"shopping"]){
                [arrayImg addObject:@"map_shop_s1"];
            }
            [array2 addObject:string1];
            [arrayZ addObject:string1];
            }
        }
        [array1 addObject:array2];
    }
    
    [db close];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    
    [self.view addSubview:scrollView];
    
    systemMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 250)];
    systemMapView.delegate=self;
    CLLocationCoordinate2D lc2d=CLLocationCoordinate2DMake([[arrayJ objectAtIndex:0]floatValue],[[arrayW objectAtIndex:0]floatValue]);
    
    MKCoordinateSpan span=MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region=MKCoordinateRegionMake(lc2d, span);
    [systemMapView setRegion:region];
    
    systemMapView.showsUserLocation=YES;
    systemMapView.mapType=MKMapTypeStandard;
    [scrollView addSubview:systemMapView];
    
    NSArray *arrayT=[NSArray arrayWithArray:arrayZ];
    
  
        
    for(int i=0;i<[arrayZ count];i++){
        
        MyAnnotation *annotation1=[[MyAnnotation alloc]initWithTitle:[arrayT objectAtIndex:i] subtitle:[arrayDescription objectAtIndex:i] location:CLLocationCoordinate2DMake([[arrayJ objectAtIndex:i]floatValue],[[arrayW objectAtIndex:i]floatValue])];
        [systemMapView addAnnotation:annotation1];
        [annotation1 release];
    
    }
    
    
 
    UIImageView *img2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_detail_jc"]];
    img2.frame=CGRectMake(0, 240, 320,10);
    [systemMapView addSubview:img2];
    
    UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_detail_cell_bg"]];
    
    [scrollView addSubview:im];
    
    UIImageView *img3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_detail_bg"]];
    
    img3.frame=CGRectMake(5, 5, 310, 150) ;
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(5,20, 280, 25)];
    label1.text=titleName;
    label1.backgroundColor=[UIColor clearColor];
    label1.font=[UIFont systemFontOfSize:17];
    [img3 addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5,50, 290, 90)];
    label2.text=descri;
    label2.textColor=[UIColor grayColor];
    label2.backgroundColor=[UIColor clearColor];
    label2.font=[UIFont systemFontOfSize:14];
    label2.numberOfLines=0;
    [img3 addSubview:label2];
    
    [im addSubview:img3];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for(int i=0;i<[array1 count];i++){
          NSMutableString *stringX=[[NSMutableString alloc]init];
        for(int j=0;j<[[array1 objectAtIndex:i] count];j++){
            [stringX appendString:[[array1 objectAtIndex:i]objectAtIndex:j]];
            if([[array1 objectAtIndex:i]count]!=1 && j!=([[array1 objectAtIndex:i] count]-1 )){
                [stringX appendString:@"→"];
                
            }
        }
        [array addObject:stringX];
    }

    for(int i=0;i<[array count];i++){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,160+i*100, 320, 100)];
        view.backgroundColor=[UIColor clearColor];
        [im addSubview:view];
        
        UIImageView *imgV1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_detail_day"]];
        imgV1.frame=CGRectMake(0, 0, 92, 33);
        UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(43, 6, 20, 20)];
        l.text=[NSString stringWithFormat:@"%d",i+1];
        
        l.backgroundColor=[UIColor clearColor];
        l.font=[UIFont systemFontOfSize:13];
        l.textColor=[UIColor whiteColor];
        [imgV1 addSubview:l];
        
        
        [view addSubview:imgV1];
        
        UIImageView *imgV2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_detail_look"]];
        imgV2.frame=CGRectMake(240, 0, 50, 25);
        
        [view addSubview:imgV2];
        
        UIImageView *imgV3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more@2x"]];
        imgV3.frame=CGRectMake(290, 45, 13,18) ;
        [view addSubview:imgV3];
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 250, 60)];
        la.text=[array objectAtIndex:i];
        la.numberOfLines=0;
        la.backgroundColor=[UIColor clearColor];
        [view addSubview:la];
        
        view.tag=500+i;
        view.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(next:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        [view addGestureRecognizer:tap];
        
    }
    im.userInteractionEnabled=YES;
    im.frame=CGRectMake(0, 250, 320, 210+([array1 count]*100));
    scrollView.contentSize=CGSizeMake(320, 460+[array1 count]*100);
    scrollView.userInteractionEnabled=YES;
    
}
-(void)next:(UITapGestureRecognizer *)tap{
    UIView *view=tap.view;
    Ceshi2ViewController *ce=[[Ceshi2ViewController alloc]init];
    ce.strName=titleName;
    ce.dayid=[[arrayId objectAtIndex:view.tag-500]integerValue];

    ce.num=(view.tag-500) +1;
    [self.navigationController pushViewController:ce animated:YES];

}
static int num=0;
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //如果当前的标记是用户当前位置
    //我们不做任何处理
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *annotationName=@"annotationName";
    
    MKAnnotationView *view=[self->systemMapView dequeueReusableAnnotationViewWithIdentifier:annotationName];
    
    if(!view){
        
        view=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationName];
        view.canShowCallout=YES;
        view.image=[UIImage imageNamed:[arrayImg objectAtIndex:num]];
        num++;
        if(num==([arrayImg count]-1 )){
            num=0;
        }
    }
    return view;
    
}

-(void)clicked:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
