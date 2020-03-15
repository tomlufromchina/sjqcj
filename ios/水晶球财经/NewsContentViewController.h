//
//  NewsContentViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsContentViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *const0Label;

@property (strong, nonatomic) IBOutlet UILabel *const1Label;

@property (strong, nonatomic) IBOutlet UILabel *contentFromLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

@property (strong, nonatomic) IBOutlet UIButton *goodButton;

@property (strong, nonatomic) IBOutlet UIButton *publishButton;


@end
