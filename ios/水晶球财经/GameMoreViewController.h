//
//  GameMoreViewController.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/26.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface GameMoreViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray* itemsArray;

@end
