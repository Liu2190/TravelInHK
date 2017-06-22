//
//  HotelItem.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "HotelItem.h"

@implementation HotelItem
@synthesize  hotelid,hotelname,typename,imageid,score,comment,jing,wei;
-(void)dealloc{
    self.hotelid=nil;
    self.hotelname=nil;
    self.typename=nil;
    self.imageid=nil;
    self.comment=nil;
    self.jing=nil;
    self.wei=nil;
    [super dealloc];
}
@end
