//
//  UpDownViewController.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/25.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface UpDownViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *topView0;
@property (weak, nonatomic) IBOutlet UITableView *famousTableView; //名人组

@property (weak, nonatomic) IBOutlet UIView *topView1;
@property (weak, nonatomic) IBOutlet UITableView *goodTableView;//精英


@end
