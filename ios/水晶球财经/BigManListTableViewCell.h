//
//  BigManListTableViewCell.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigManListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *describLabel;

@property (strong, nonatomic) IBOutlet UIButton *addButton;


@end
