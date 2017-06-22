//
//  CollectViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *myTableView;
    NSMutableArray *dataArray;
    NSMutableArray *jingdian;
    NSMutableArray *zhusu;
    NSMutableArray *meishi;
    NSMutableArray *gouwu;
    NSMutableArray *yule;
    NSMutableArray *arrayItem;
    NSMutableArray *arrayZong;
    NSMutableArray *arrayBaokuo;
    UIView *smile;
}
@property(nonatomic,retain)NSString *path;
@end
