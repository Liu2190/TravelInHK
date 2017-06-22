//
//  MyAnnotation.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-7.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
-(void)dealloc
{
    [title release];
    title=nil;
    [subTitle release];
    subTitle=nil;
    [super dealloc];
}
-(id)initWithTitle:(NSString *)newTitle subtitle:(NSString *)newSubTitle location:(CLLocationCoordinate2D)location
{
    if (self=[super init]) {
        title=[newTitle copy];
        subTitle=[newSubTitle copy];
        lc2d=location;
    }
    return self;
}
//协议方法
-(NSString*)title
{
    return title;
}
-(NSString*)subtitle
{
    return subTitle;
}
-(CLLocationCoordinate2D)coordinate
{
    return lc2d;
}
@end
