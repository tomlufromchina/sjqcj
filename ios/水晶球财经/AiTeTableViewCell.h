//
//  AiTeTableViewCell.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/18.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AiTeTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageView0; //头像0
@property (weak, nonatomic) IBOutlet UILabel *nameLabel0; //名字0
@property (weak, nonatomic) IBOutlet UILabel *timeLabel0; //时间0
@property (weak, nonatomic) IBOutlet UILabel *constLabel0; //转发微博
@property (weak, nonatomic) IBOutlet UITextView *textView0; //textView0



@property (weak, nonatomic) IBOutlet UIView *backgroundView1;  //背景View 包含用户1的全部控件
@property (weak, nonatomic) IBOutlet UIImageView *imageView1; //头像1
@property (weak, nonatomic) IBOutlet UILabel *nameLabel1;     //名字1
@property (weak, nonatomic) IBOutlet UITextView *textView1;    //textView1


@property (weak, nonatomic) IBOutlet UIButton *replayButton; //转发
@property (weak, nonatomic) IBOutlet UIButton *goodButton;    //点赞
@property (weak, nonatomic) IBOutlet UIButton *commentButton;  //评论


@property (weak, nonatomic) IBOutlet UIView *buttomView; //底部线条

@end
