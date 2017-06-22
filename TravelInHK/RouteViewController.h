//
//  RouteViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteViewController : UIViewController{
    NSMutableArray * arrayTitle;
    NSMutableArray *arrayDes;
    NSMutableArray *arrayImg;
    NSMutableArray *arrayPlanId;
}

@property(nonatomic,retain)NSString *path;

@end
