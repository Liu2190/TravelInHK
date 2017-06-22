//
//  FoodItem.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject
@property(nonatomic,retain)NSString *restaurant_id;
@property(nonatomic,retain)NSString *restaurant_name;
@property(nonatomic,retain)NSString *restaurant_type;
@property(nonatomic,retain)NSString *restaurant_logo;

@property(nonatomic,assign)float score;
@property(nonatomic,retain)NSString *restaurant_introduce;

@property(nonatomic,retain)NSString *jing;
@property(nonatomic,retain)NSString *wei;
@end
