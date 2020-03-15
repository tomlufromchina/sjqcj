//
//  WeiBoTableViewCell.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/30.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>


///////////////////////////////////////////////////////////////////////

@interface WeiBoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;  //头像

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;  //名字

@property (strong, nonatomic) IBOutlet UITextView *contentLabel; //显示内容 textview

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;   //时间

@property (strong, nonatomic) IBOutlet UIButton *relayButton; //转发
@property (strong, nonatomic) IBOutlet UIButton *goodButton;  //点赞
@property (strong, nonatomic) IBOutlet UIButton *speakButton;  //评论





@property (strong, nonatomic) IBOutlet UILabel *no0Label; //转发数

@property (strong, nonatomic) IBOutlet UILabel *no1Label; //点赞数

@property (strong, nonatomic) IBOutlet UILabel *no3Label; //发言数



@property(strong,nonatomic)UIView* bottomLine; //最后一根线
///////////////////////////////////////////////////////////////////////


@end
