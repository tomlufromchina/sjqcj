//
//  EditWeiBoViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/11/1.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface EditWeiBoViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;  //背景scrollView

@property (strong, nonatomic) IBOutlet UITextView *contentTV;    //输入内容



@end
