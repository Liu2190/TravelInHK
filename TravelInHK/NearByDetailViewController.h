//
//  NearByDetailViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-16.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByDetailViewController : UIViewController{
    UIImageView * all;
    UILabel * allTitle;
    UIImageView *deImg;
    UILabel *defaultTitle;
    NSArray *array2;
    UIView * viewDef;
    NSArray *array4;
    UIView * viewAll;
    UIView *view;
}
@property(nonatomic,assign)NSInteger numid;
@end
