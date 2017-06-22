//
//  HttpDownload.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-17.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpDownload : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *httpConnection;
    NSMutableData *downloadData;
}
@property(readonly,nonatomic)NSMutableData *downloadData;
@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)SEL method;
@property(nonatomic,assign)NSInteger type;
-(void)downloadFromUrl:(NSString *)url;

@end
