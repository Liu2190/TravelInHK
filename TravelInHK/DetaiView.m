//
//  DetaiView.m
//  香港旅游
//
//  Created by qianfeng on 13-7-4.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "DetaiView.h"
#import "BtnDelegate.h"
@implementation DetaiView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    
    [_IMG1 release];
    [_IMG2 release];
    [_BTN1 release];
    [_BTN2 release];
    [_BTN3 release];
    [_BTN4 release];
    [_BTN5 release];
    [_BTN6 release];
    [_BTN7 release];
    [_BTN8 release];
    [_LABEL1 release];
    [_LABEL2 release];
    [_LABEL3 release];
    [_LABEL4 release];
    [_LABEL5 release];
    [_LABEL5 release];
    [_LABEL6 release];
    [_LABEL7 release];
    [_LABEL8 release];
  
    [_Title release];
   
    [_Button9 release];
    [_gonglue release];
    [super dealloc];
}

- (IBAction)Btnclicked:(UIButton *)sender {
   
    [self.delegate pushDetail:sender];
}
@end
