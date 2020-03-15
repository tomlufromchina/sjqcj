//
//  RotateViewController.h
//  Crystal
//
//  Created by Tom lu on 15/10/26.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol firstScrollDelegate <NSObject>
@required
-(void)lsatPageTapAction;
@end


@interface RotateViewController : UIViewController

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(assign, nonatomic) id<firstScrollDelegate> delegate;

@end
