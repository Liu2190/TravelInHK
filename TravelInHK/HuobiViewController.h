//
//  HuobiViewController.h
//  TravelInHK
//
//  Created by qianfeng on 13-7-15.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuobiViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate>{
    UIActionSheet *sheet1;
    UIActionSheet *sheet2;
    UILabel *label1;
    UILabel *label2;
    NSMutableArray *dataArray;
    UITextField *tf1;
    UITextField *tf2;
    NSMutableArray *array;
}

@end
