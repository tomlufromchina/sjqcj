//
//  NewsContentViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "NewsContentViewController.h"
#import "UIViewExt.h"
@interface NewsContentViewController ()

@end

@implementation NewsContentViewController
@synthesize titleLabel = _titleLabel;
@synthesize const0Label = _const0Label;
@synthesize const1Label = _const1Label;
@synthesize contentFromLabel = _contentFromLabel;
@synthesize timeLabel = _timeLabel;
@synthesize contentTextView = _contentTextView;
@synthesize goodButton = _goodButton;
@synthesize publishButton = _publishButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"财经热点";
    self.view.backgroundColor = APPBackColor;
    _titleLabel.centerX = SCREENWIDTH * 0.5;
    _titleLabel.top = 20;
    
    _const0Label.top = _const1Label.top = _contentFromLabel.top = _timeLabel.top = _titleLabel.bottom + 10;
    _const0Label.left  = 30;
    _contentFromLabel.left = _const0Label.right;
    _timeLabel.right = SCREENWIDTH-30;
    _const1Label.right = _timeLabel.left;
    
    _contentTextView.backgroundColor = [UIColor whiteColor];
    _contentTextView.top = _timeLabel.bottom + 20;
    _contentTextView.left =  30;
    _contentTextView.width = SCREENWIDTH - 60;
    _goodButton.top = _publishButton.top = _contentTextView.bottom+20;
    _publishButton.right = _contentTextView.right;
    _goodButton.right = _publishButton.left - 30;
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
