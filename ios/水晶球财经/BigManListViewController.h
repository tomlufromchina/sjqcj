//
//  BigManListViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface BigManListViewController : BaseViewController

@property(nonatomic,strong)NSArray* bigManArray;  //接收传递过来的
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
