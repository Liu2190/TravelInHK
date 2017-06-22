//
//  ZuijiaViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZuijiaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *myTableView;
    NSMutableArray *dataArray;
    NSMutableArray *arrayId;
}
@property(nonatomic,retain)NSString *path;
@end
