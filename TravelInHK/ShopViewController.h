//
//  ShopViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ShopViewController :UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate>{
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
    
    NSMutableArray *gouwujie;
    NSMutableArray *laozihao;
    NSMutableArray *techandian;
    NSMutableArray *xiaodian;
    NSMutableArray *shangchang;
    NSMutableArray *mianshuidian;
    NSMutableArray *shudian;
    NSMutableArray *outlet;
    NSMutableArray *jishi;
    NSMutableArray *yaozhuang;
    NSMutableArray *pingfen;
    NSMutableArray *juli;
    NSMutableArray *zongshuzu;
    
    NSArray *array2;
    NSArray *array4;
    NSMutableArray *totalMap;
    NSMutableArray *ditu;
    
}
@property(nonatomic,retain)NSString *path;

@end
