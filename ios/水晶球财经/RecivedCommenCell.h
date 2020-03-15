//
//  RecivedCommenCell.h
//  评论demo
//
//  Created by Tom lu on 15/11/13.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecivedCommenCell : UITableViewCell

//回复信息
@property (strong, nonatomic) IBOutlet UIImageView *imageView0;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel0;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel0;
@property (strong, nonatomic) IBOutlet UIButton *replyButton; //回复按钮
@property (strong, nonatomic) IBOutlet UITextView *textView0;


@property (strong, nonatomic) IBOutlet UIView *middleLine;///////中线


@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel1;
@property (strong, nonatomic) IBOutlet UITextView *textView1;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel1;


@property (strong, nonatomic) IBOutlet UIView *bottomLine;//底部线条


@end
