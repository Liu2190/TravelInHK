//
//  Ceshi2ViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-9.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "Ceshi2ViewController.h"
#import "MyAnnotation.h"
#import "Ceshi3ViewController.h"
#import "FMDatabase.h"
#import "Ceshi4ViewController.h"
#import "Ceshi5ViewController.h"
@interface Ceshi2ViewController ()

@end

@implementation Ceshi2ViewController
@synthesize strName,num,dayid,path;
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
    self.navigationItem.title=[NSString stringWithFormat:@"第%d天行程",num];
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    scrollView.contentSize=CGSizeMake(320,320+415*5+40);
    [self.view addSubview:scrollView];
    
    systemMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 250)];
    systemMapView.delegate=self;
    CLLocationCoordinate2D lc2d=CLLocationCoordinate2DMake(22.3073,114.1702);
    
    MKCoordinateSpan span=MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region=MKCoordinateRegionMake(lc2d, span);
    [systemMapView setRegion:region];
    systemMapView.showsUserLocation=YES;
    systemMapView.mapType=MKMapTypeStandard;
    [scrollView addSubview:systemMapView];
    
    
    UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_start"]];
    im.frame=CGRectMake(0, 250, 320, 78);
    UIImageView *im99=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat: @"line_active_day%d",num]]];
    im99.frame=CGRectMake(70,10, 58, 52);
    [im addSubview:im99];
    UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake(130, 10, 250, 50)];
    l1.text=strName;
    l1.textColor=[UIColor whiteColor];
    l1.font=[UIFont systemFontOfSize:17];
    l1.backgroundColor=[UIColor clearColor];
    [im addSubview:l1];
    [scrollView addSubview:im];
    
    
    
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"4265.guide.v39.39.39.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    
    BOOL res=[db open];
    if(res==NO){
        NSLog(@"打开失败");
        return;
    }
    FMResultSet *set=[db executeQuery:[NSString stringWithFormat:@"select * from listdo_travel_activities where dayid='%d' ORDER BY orderid ASC",dayid]];
    linkType=[[NSMutableArray alloc]init];
    linkId=[[NSMutableArray alloc]init];
    NSMutableArray *arrayJ=[[NSMutableArray alloc]init];
    NSMutableArray *arrayW=[[NSMutableArray alloc]init];
    arrayT=[[NSMutableArray alloc]init];
    NSMutableArray *arrayS=[[NSMutableArray alloc]init];
    NSMutableArray *arrayType=[[NSMutableArray alloc]init];
    NSMutableArray *arrayLinktype=[[NSMutableArray alloc]init];
    NSMutableArray *arrayZongtimu=[[NSMutableArray alloc]init];
    NSMutableArray *arrayZongxijie=[[NSMutableArray alloc]init];
    NSMutableArray *arrayImg=[[NSMutableArray alloc]init];
    while([set next]){
        NSString  * string=[set objectForColumnName:@"type"];
        [arrayType addObject:string];
        NSString *string2=[set objectForColumnName:@"linktype"];
        [arrayLinktype addObject:string2];
        if([string isEqualToString:@"other"]){
            NSString *strT=[set objectForColumnName:@"title"];
            NSString *strS=[set objectForColumnName:@"description"];
            [ arrayZongtimu addObject:strT];
            [arrayZongxijie addObject:strS];
        }
        else{
            NSString *strJ=[set objectForColumnName:@"map_lat"];
            NSString *strW=[set objectForColumnName:@"map_lng"];
            NSString *strT=[set objectForColumnName:@"title"];
            NSString *strS=[set objectForColumnName:@"description"];
            NSString *strI=[set objectForColumnName:@"logo"];
            NSString *linktype=[set objectForColumnName:@"linktype"];
            [linkType addObject:linktype];
            [arrayImg addObject:[[strI componentsSeparatedByString:@"/"] objectAtIndex:1]];
            [arrayS addObject:strS];
            [arrayT addObject:strT];
            [arrayJ addObject:strJ];
            [arrayW addObject:strW];
            [arrayZongtimu addObject:strT];
            [arrayZongxijie addObject:strS];
            NSString * data=[set objectForColumnName:@"linkid"];
            [linkId addObject:data];
           
            
        }
        
        
    }
      [db close];
    
    for(int i=0;i<[arrayT count];i++){
        MyAnnotation *annotation=[[MyAnnotation alloc]initWithTitle:[arrayT objectAtIndex:i] subtitle:[arrayS objectAtIndex:i] location:CLLocationCoordinate2DMake([[arrayJ objectAtIndex:i]floatValue],[[arrayW objectAtIndex:i]floatValue])];
        [systemMapView addAnnotation:annotation];
        [annotation release];
    }
 
  
    
    int g=0;
    float y=250+78;
    for(int i=0;i<[arrayZongtimu count];i++){
        
      

       
        if([[arrayType objectAtIndex:i] isEqualToString:@"other"]==1)
        {
            UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_bg"]];
            
            
            UIImageView *view1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_jt_top"]];
            [view addSubview:view1];
            
            UIImageView *view2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_bus"]];
            view2.frame=CGRectMake(12, 20, 30, 30);
             [view addSubview:view2];
            
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(18, 5, 223, 20)];
            label1.text=[arrayZongtimu objectAtIndex:i];
            label1.backgroundColor=[UIColor clearColor];
            [view1 addSubview:label1];
            
            UILabel *label2=[[UILabel alloc]init];
            NSString *str=[arrayZongxijie objectAtIndex:i];
            UIFont *f=[UIFont fontWithName:@"Arial" size:13];
            CGSize maxSize=CGSizeMake(223,600);
            CGSize size=[str sizeWithFont:f constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
           
            label2.text=str;
            label2.frame=CGRectMake(18, 30, 223, size.height);
            label2.backgroundColor=[UIColor clearColor];
            label2.numberOfLines=0;
            label2.font=f;
            label2.textColor=[UIColor grayColor];
            [view1 addSubview:label2];
            
            view1.frame=CGRectMake(50,10,263,40+size.height);
            
            view.frame=CGRectMake(0, y, 320, view1.frame.size.height+20);
            y=view.frame.origin.y+view.frame.size.height;
            [scrollView addSubview:view];
        }
        else{
            UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_bg"]];
            
            UIImageView *view1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_top"]];
            view1.frame=CGRectMake(50, 10, 263, 195);
            
            UIImageView *imgBack=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[arrayImg objectAtIndex:g]]];
            imgBack.tag=500+g;
            UITapGestureRecognizer *gest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(next:)];
            gest.numberOfTapsRequired=1;
            gest.numberOfTouchesRequired=1;
            [imgBack addGestureRecognizer:gest];
            imgBack.userInteractionEnabled=YES;
            imgBack.frame=CGRectMake(13, 45, 240, 150);
            [view1 addSubview:imgBack];
            view1.userInteractionEnabled=YES;
            UIImageView *imgWhe=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat: @"ling_where_%d",g+1]]];
            
            imgWhe.frame=CGRectMake(15, 5, 37, 35);
            [view1 addSubview:imgWhe];
            
            UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(80,5,180, 30)];
            la1.text=[arrayZongtimu objectAtIndex:i];
            la1.backgroundColor=[UIColor clearColor];
            [view1 addSubview:la1];
            
            [view addSubview:view1];
            
            view.userInteractionEnabled=YES;
            if([[arrayLinktype objectAtIndex:i] isEqualToString:@"shopping"]==1){
                
                UIImageView *view2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_shopping"]];
                view2.frame=CGRectMake(12, 20, 30, 30);
                            [view addSubview:view2];
            }
            else if([[arrayLinktype objectAtIndex:i]isEqualToString:@"scenic"]==1){
                UIImageView *view2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_scenic"]];
                view2.frame=CGRectMake(12, 20, 30, 30);
                [view addSubview:view2];
            }
            else if ([[arrayLinktype objectAtIndex:i]isEqualToString:@"restaurant"]==1){
                UIImageView *view2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_restaurant"]];
                view2.frame=CGRectMake(12, 20, 30, 30);
                 [view addSubview:view2];
            }
            
            UIImageView *view3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_body"]];
            
            UILabel *label2=[[UILabel alloc]init];
            NSString *str=[arrayZongxijie objectAtIndex:i];
            UIFont *f=[UIFont fontWithName:@"Arial" size:15];
            CGSize maxSize=CGSizeMake(223,600);
            CGSize size=[str sizeWithFont:f constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
          
            label2.text=str;
            label2.font=f;
            label2.frame=CGRectMake(10, 5, 240, size.height);
            label2.backgroundColor=[UIColor clearColor];
            label2.numberOfLines=0;
            
            [view3 addSubview:label2];
            [view addSubview:view3];
            
            view3.frame=CGRectMake(50,10+195, 264, size.height+10);
            
            view.frame=CGRectMake(0, y, 320, 10+195+view3.frame.size.height);
            y=view.frame.origin.y+view.frame.size.height;
            g++;
            [scrollView addSubview:view];
        }
        
    }
    
    UIImageView *imgOver=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_active_over"]];
    imgOver.frame=CGRectMake(0, y, 320, 40);
    [scrollView addSubview:imgOver];
    scrollView.contentSize=CGSizeMake(320,y+40);
    scrollView.userInteractionEnabled=YES;

    
    
}
-(void)next:(UITapGestureRecognizer *)tap{
    
    UIView *view=tap.view;
    
    NSString *st=[linkType objectAtIndex:view.tag-500];
    if([st isEqualToString:@"scenic"]==1){
    Ceshi3ViewController *ce=[[Ceshi3ViewController alloc]init];
 
    ce.linkid=[[linkId objectAtIndex:view.tag-500]integerValue];
    ce.linktype=st;
    [self.navigationController pushViewController:ce animated:YES];
    [ce release];
    }
    if([st isEqualToString:@"shopping"]==1){
        Ceshi4ViewController *ce=[[Ceshi4ViewController alloc]init];
        ce.linkid=[[linkId objectAtIndex:view.tag-500]integerValue];
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
    if([st isEqualToString:@"restaurant"]==1){
        Ceshi5ViewController *ce=[[Ceshi5ViewController alloc]init];
        ce.linkid=[[linkId objectAtIndex:view.tag-500]integerValue];
        [self.navigationController pushViewController:ce animated:YES];
        [ce release];
    }
   
}



static int indexNum=0;
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
       
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *annotationName=@"annotationName";
    
    
    MKAnnotationView *view=[self->systemMapView dequeueReusableAnnotationViewWithIdentifier:annotationName];
    if(!view){
        view=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationName];
        view.canShowCallout=YES;
        view.image=[UIImage imageNamed:[NSString stringWithFormat: @"ling_where_%d",indexNum+1]];
        indexNum++;
        if(indexNum==[arrayT count]){
            indexNum=0;
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
