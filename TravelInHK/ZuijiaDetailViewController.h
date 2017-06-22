//
//  ZuijiaDetailViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZuijiaDetailViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,assign)NSInteger dataid;
@property(nonatomic,retain)NSString *path;
@end
