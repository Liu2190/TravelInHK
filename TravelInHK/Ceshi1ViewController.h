//
//  Ceshi1ViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-9.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface Ceshi1ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *systemMapView;
    CLLocationManager *locationManager;
    NSMutableArray *arrayLinkId;
    NSMutableArray *arrayJ;
    NSMutableArray *arrayW;
    NSMutableArray *arrayImg;
    NSString *titleName;
    NSMutableArray *tianshu;
    NSMutableArray *arrayId;
}
@property(nonatomic,retain)NSString *planid;
@property(nonatomic,retain)NSString *titleName;
@property(nonatomic,retain)NSString *descri;
@property(nonatomic,retain)NSString *path;
@end
