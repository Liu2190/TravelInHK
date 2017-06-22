//
//  CItem.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-16.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CItem : NSObject
@property(nonatomic,retain)NSString *title;
@property(nonatomic,assign)NSInteger idNum;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,assign)float score;
@property(nonatomic,retain)NSString *address;
@property(nonatomic,retain)NSString *img;
@property(nonatomic,retain)NSString *type;
@end
