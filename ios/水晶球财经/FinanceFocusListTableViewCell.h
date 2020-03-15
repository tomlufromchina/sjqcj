//
//  FinanceFocusListTableViewCell.h
//  水晶球财经
//
//  Created by Tom lu on 15/11/3.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanceFocusListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel; //标题
@property (strong, nonatomic) IBOutlet UILabel *createTimeLabel;//创建时间
@property (strong, nonatomic) IBOutlet UILabel *const0Label; //阅读 const
@property (strong, nonatomic) IBOutlet UILabel *const1Label; //评论 const

@property (strong, nonatomic) IBOutlet UILabel *readCountLabel;//阅读数
@property (strong, nonatomic) IBOutlet UILabel *commentCountLabel;//评论数


@end
