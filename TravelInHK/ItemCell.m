//
//  ItemCell.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-11.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell
@synthesize scenicname,logo,content,score,pricesummary,scenicid,aword,jing,wei;
-(void)dealloc{
    self.pricesummary=nil;
    self.scenicname=nil;
    self.logo=nil;
    self.content=nil;
    self.scenicid=nil;
    self.aword=nil;
    self.jing=nil;
    self.wei=nil;
    [super dealloc];
}
@end
