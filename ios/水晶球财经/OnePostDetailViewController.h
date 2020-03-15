//
//  OnePostDetailViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface OnePostDetailViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;


///////////////////////重要数据///////////
@property(nonatomic,strong)NSString* feed_id; //微博id
@property(nonatomic,strong)NSString* mid;     //当前用户的ID
@end
