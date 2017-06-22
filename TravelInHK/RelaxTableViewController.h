//
//  RelaxTableViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-13.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelaxTableViewController: UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *myTableview;
    NSMutableArray *dataArray;
    NSMutableString *strImg;
    NSMutableString *price_details;
    NSInteger linkid;
    UIImageView *view99;
}
@property(nonatomic,assign)NSInteger linkid;
@property(nonatomic,retain)NSString *path;
@property(nonatomic,retain)NSString *linktype;
@property(nonatomic,retain)NSString *path1;

@end
