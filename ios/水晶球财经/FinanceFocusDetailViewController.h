//
//  FinanceFocusDetailViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/11/3.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface FinanceFocusDetailViewController : BaseViewController

@property(strong, nonatomic)NSString* financeID; // id 传递过来

@property (strong, nonatomic) IBOutlet UILabel *titleLabel; //标题
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;  //发布时间


@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIView *bottomView; //包含了一个TF 和 一个 button

@property (strong, nonatomic) IBOutlet UITextField *textFeild;

@property (strong, nonatomic) IBOutlet UIButton *publicButton;


@end
