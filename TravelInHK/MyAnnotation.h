//
//  MyAnnotation.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-7.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>{
    NSString *title;
    NSString *subTitle;
    CLLocationCoordinate2D lc2d;
    
}
-(id)initWithTitle:(NSString *)newTitle subtitle:(NSString*)newSubTitle location:(CLLocationCoordinate2D)location;
@end
