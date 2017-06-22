//
//  Ceshi3ViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-9.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ceshi3ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *myTableview;
    NSMutableArray *dataArray;
    NSMutableString *strImg;
  
    NSInteger linkid;
    UIImageView *view99;
    int flag;
}
@property(nonatomic,assign)NSInteger linkid;
@property(nonatomic,retain)NSString *path;
@property(nonatomic,retain)NSString *linktype;
@property(nonatomic,retain)NSString *path1;
@end
