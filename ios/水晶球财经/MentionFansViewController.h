//
//  MentionFansViewController.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface MentionFansViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;



//传递过来的标题：关注或者粉丝
@property(nonatomic,strong)NSString* titleForVC;

@end
