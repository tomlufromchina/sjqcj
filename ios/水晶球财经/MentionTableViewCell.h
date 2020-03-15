//
//  MentionTableViewCell.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MentionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;  //头像

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;  //名字

@property (weak, nonatomic) IBOutlet UILabel *describLabel; //描述

@end
