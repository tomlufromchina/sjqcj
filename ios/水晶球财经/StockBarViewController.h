//
//  StockBarViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/11/12.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface StockBarViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *headView;


@property (strong, nonatomic) IBOutlet UITableView *topPostTableView;//置顶帖


@property (strong, nonatomic) IBOutlet UITableView *tableView; //显示微博



@end
