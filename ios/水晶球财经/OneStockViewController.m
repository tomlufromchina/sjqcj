//
//  OneStockViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "OneStockViewController.h"
#import "UILabel+ChangeBoundByString.h"
#import "UIViewExt.h"

@interface OneStockViewController ()

@end

@implementation OneStockViewController
@synthesize detailLabel = _detailLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"股票详情";
    NSString* str = @"这是一张好股票，去年开始跌跌跌，那叫一个痛啊。好多人都觉得太刺激了，不过，我们相信，今年一定会大涨的,一定的！";
    [_detailLabel removeFromSuperview];
    _detailLabel = [UILabel linesText:str font:_detailLabel.font wid:_detailLabel.width lines:0 color:_detailLabel.textColor];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableview delegate 


@end
