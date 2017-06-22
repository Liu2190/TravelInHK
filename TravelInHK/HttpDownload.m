//
//  HttpDownload.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-17.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "HttpDownload.h"

@implementation HttpDownload
@synthesize delegate,method,downloadData,type;
-(id)init{
    if(self=[super init]){
        downloadData=[[NSMutableData alloc]init];
    }
    return self;
}
-(void)downloadFromUrl:(NSString *)newurl{
    
    if(httpConnection){
        [httpConnection release];
        httpConnection=nil;
    }
    if(type==1){
    NSURL *url=[NSURL URLWithString:newurl];
      
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        httpConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    else if(type==2){
        NSURL *url=[NSURL fileURLWithPath:newurl];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        httpConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    if([response isKindOfClass:[NSHTTPURLResponse class]]){
        NSHTTPURLResponse *newResponse=(NSHTTPURLResponse *)response;
        NSLog(@"states_code:%d",[newResponse statusCode]);
    }
    [downloadData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [downloadData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if([self.delegate respondsToSelector:self.method]){
        [self.delegate performSelector:self.method withObject:self];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"请求失败:%@",[error localizedFailureReason]);
}

@end
