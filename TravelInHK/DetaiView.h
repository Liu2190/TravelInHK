//
//  DetaiView.h
//  香港旅游
//
//  Created by qianfeng on 13-7-4.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetaiView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *IMG1;
@property (retain, nonatomic) IBOutlet UIImageView *IMG2;
@property (retain, nonatomic) IBOutlet UIButton *BTN1;
@property (retain, nonatomic) IBOutlet UIButton *BTN2;
@property (retain, nonatomic) IBOutlet UIButton *BTN3;
@property (retain, nonatomic) IBOutlet UIButton *BTN4;

@property (retain, nonatomic) IBOutlet UIButton *BTN5;
@property (retain, nonatomic) IBOutlet UIButton *BTN6;

@property (retain, nonatomic) IBOutlet UIButton *BTN7;

@property (retain, nonatomic) IBOutlet UIButton *BTN8;

@property (retain, nonatomic) IBOutlet UILabel *LABEL1;

@property (retain, nonatomic) IBOutlet UILabel *LABEL2;

@property (retain, nonatomic) IBOutlet UILabel *LABEL3;

@property (retain, nonatomic) IBOutlet UILabel *LABEL4;

@property (retain, nonatomic) IBOutlet UILabel *LABEL5;

@property (retain, nonatomic) IBOutlet UILabel *LABEL6;

@property (retain, nonatomic) IBOutlet UILabel *LABEL7;

@property (retain, nonatomic) IBOutlet UILabel *LABEL8;

@property (retain, nonatomic) IBOutlet UIImageView *Title;

@property (retain, nonatomic) IBOutlet UIButton *Button9;

- (IBAction)Btnclicked:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIImageView *gonglue;

@property(nonatomic,assign)id delegate;





@end
