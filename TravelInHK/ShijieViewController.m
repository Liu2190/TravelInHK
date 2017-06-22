//
//  ShijieViewController.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "ShijieViewController.h"
#import "CellItem.h"
@interface ShijieViewController ()

@end

@implementation ShijieViewController

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
    self.navigationItem.title=@"世界时间";
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header-back"]];
    img.userInteractionEnabled=YES;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithCustomView:img];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [img addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=button;
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(mytimer:) userInfo:nil repeats:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
 
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
    [dateFormatter release];
 
    
    NSString *filepath=[[NSBundle mainBundle]pathForResource:@"CityZone" ofType:@"plist"];
    dataArray=[[NSMutableArray alloc]initWithContentsOfFile:filepath];
    
  //  imageView.transform = CGAffineTransformMakeRotation(CGFloat angle);
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else{
        return [dataArray count];
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0){
        return [NSString stringWithFormat:@"常用时区"];
    }
    else{
        return [NSString stringWithFormat:@"所有时区"];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"CellItem";
    CellItem *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CellItem" owner:self options:nil]lastObject];
        
    }
  
    NSDictionary *dict=[dataArray objectAtIndex:indexPath.row];
       
       cell.name.text=[dict objectForKey:@"City"];
        
        NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
        NSDate *date = [NSDate date];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
        NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
        NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
        NSInteger unitFlags = NSYearCalendarUnit |
        NSMonthCalendarUnit |
        NSDayCalendarUnit |
        NSWeekdayCalendarUnit |
        NSHourCalendarUnit |
        NSMinuteCalendarUnit |
        NSSecondCalendarUnit;
        
        comps = [calendar components:unitFlags fromDate:date];
   //     int week = [comps weekday]-1 ;
        int year=[comps year];
        int month = [comps month];
        int day = [comps day];
        
        int hour = [comps hour];
        int min = [comps minute];
 //       int sec = [comps second];

    
       
        

        if(hour-(8-[[dict objectForKey:@"TimeZone"]integerValue])>0 && hour-(8-[[dict objectForKey:@"TimeZone"]integerValue])<24 ){
            cell.timeLabel.text=[NSString stringWithFormat:@"%02d:%02d",hour-(8-[[dict objectForKey:@"TimeZone"]integerValue]),min];
            
            
           cell.dateLabel.text=[NSString stringWithFormat:@"%d-%d-%02d",year,month,day];
            
            
            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TimeZone_szbp"]];
            im.frame=CGRectMake(0, 0, 80, 80);
            UIImageView *im1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TimeZone_sz"]];
            im1.frame=CGRectMake(40, 40, 3, 35);
            CGFloat f=(hour-(8-[[dict objectForKey:@"TimeZone"]integerValue]))/24;
            im1.transform = CGAffineTransformMakeRotation(f);
            [im addSubview:im1];

            [cell.img addSubview:im];
            

            return cell;
        }else if(hour-(8-[[dict objectForKey:@"TimeZone"]integerValue])<0){
        cell.timeLabel.text=[NSString stringWithFormat:@"%02d:%02d",24+hour-(8-[[dict objectForKey:@"TimeZone"]integerValue]),min];
          
           
           cell.dateLabel.text=[NSString stringWithFormat:@"%d-%d-%02d",year,month,day-1];
             cell.img.image=[UIImage imageNamed:@"TimeZone_szbp"];
            return cell;
        }
        else {
            cell.timeLabel.text=[NSString stringWithFormat:@"%02d:%02d",24-hour+(8-[[dict objectForKey:@"TimeZone"]integerValue]),min];
            
            
            cell.dateLabel.text=[NSString stringWithFormat:@"%d-%d-%02d",year,month,day+1];
            
                        cell.img.image=[UIImage imageNamed:@"TimeZone_szbp"];
            return cell;
        }
        
 
}
-(void)mytimer:(id)arg{
    
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
