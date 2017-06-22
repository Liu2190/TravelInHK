//
//  HuobiItem.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-17.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "HuobiItem.h"

@implementation HuobiItem
@synthesize name,code,price,logo;
-(void)dealloc{
    self.name=nil;
    self.code=nil;
    self.price=nil;
    self.logo=nil;
    [super dealloc];
}
@end
