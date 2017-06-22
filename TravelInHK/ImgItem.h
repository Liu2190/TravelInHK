//
//  ImgItem.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"
@interface ImgItem : UIView
@property(nonatomic,retain)MyAnnotation *annotion;
@property(nonatomic,retain)  MKAnnotationView *view;
@end
