//
//  HotelItem.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelItem : NSObject
@property(nonatomic,retain)NSString *hotelid;
@property(nonatomic,retain)NSString *hotelname;
@property(nonatomic,retain)NSString *typename;
@property(nonatomic,retain)NSString *imageid;

@property(nonatomic,assign)float score;
@property(nonatomic,retain)NSString *comment;

@property(nonatomic,retain)NSString *jing;
@property(nonatomic,retain)NSString *wei;
@end
