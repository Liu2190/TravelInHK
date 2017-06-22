//
//  FoodItem.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "FoodItem.h"

@implementation FoodItem
@synthesize restaurant_id,restaurant_name,restaurant_type,restaurant_logo,score,restaurant_introduce,jing,wei;
-(void)dealloc{
    self.restaurant_id=nil;
    self.restaurant_name=nil;
    self.restaurant_type=nil;
    self.restaurant_logo=nil;
    self.restaurant_introduce=nil;
    self.jing=nil;
    self.wei=nil;
    [super dealloc];
}
@end
