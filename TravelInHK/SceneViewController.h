//
//  SceneViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SceneViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *systemMapView;
    CLLocationManager *locationManager;
    UITableView *myTableview;
    NSMutableArray *arrayTotal;
    NSMutableArray *dataArray;
    
    UIImageView *img1;
    UIImageView *all;
    UIImageView *deImg;
    UIView *view;
    UILabel *allTitle;
    UILabel *defaultTitle;
    UIView *viewAll;
    UIView *viewDef;
    BOOL  _loadingMore;
    NSUInteger dataNumber;
    
    NSMutableArray *fengjingmingsheng;
    NSMutableArray *gongyuan;
    NSMutableArray *xiandaijianzhu;
    NSMutableArray *youlechang;
    NSMutableArray *zongjiaochangsuo;
    NSMutableArray *tesejiequ;
    NSMutableArray *qita;
    NSMutableArray *bowugaun;
    NSMutableArray *guji;
    NSMutableArray *xiuxiandujia;
    NSMutableArray *xuefu;
    NSMutableArray *zongshuzu;
    NSMutableArray *pingfengpaixu;
    NSMutableArray *julipaixu;
    NSArray *array2;
    NSArray *array4;
    NSMutableArray *totalMap;
    NSMutableArray *ditu;

}
@property(nonatomic,retain)NSString *path;
@end
