//
//  Ceshi2ViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-9.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Ceshi2ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *systemMapView;
    CLLocationManager *locationManager;
    NSMutableArray *arrayT;
    NSMutableArray *linkId;
    NSMutableArray *linkType;
 
}
@property(nonatomic,retain)NSString *strName;
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,assign)NSInteger dayid;
@property(nonatomic,retain)NSString *path;
@end
