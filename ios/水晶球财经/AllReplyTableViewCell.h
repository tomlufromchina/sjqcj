//
//  AllReplyTableViewCell.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllReplyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView; //头像
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;  //名字
@property (strong, nonatomic) IBOutlet UILabel *floorLabel;  //第几楼

@property (strong, nonatomic) IBOutlet UITextView *textView; //显示内容




@property (strong, nonatomic) IBOutlet UILabel *createTimeLabel; //创建时间


@property (strong, nonatomic) IBOutlet UIButton *RePostButton; //转发按钮

@property (strong, nonatomic) IBOutlet UIButton *speakButton;//回复按钮








@end
