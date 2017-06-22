//
//  CItem.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-16.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "CItem.h"

@implementation CItem
@synthesize title,idNum,name,address,img,type;
-(void)dealloc{
    self.title=nil;
    self.name=nil;
    self.address=nil;
    self.img=nil;
    self.type=nil;
    [super dealloc];
}
@end
