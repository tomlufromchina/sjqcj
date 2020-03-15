//
//  TransmitViewController.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/17.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface TransmitViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;


///////////////需要父视图传递过来的参数
@property(nonatomic,strong)NSString* feed_id;


@end
