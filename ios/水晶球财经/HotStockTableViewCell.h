//
//  HotStockTableViewCell.h
//  Crystal
//
//  Created by Tom lu on 15/10/27.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotStockTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *stockNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *stockNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *changeLabel;
@property (strong, nonatomic) IBOutlet UIButton *addButton;



@end
