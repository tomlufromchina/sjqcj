//
//  HomePageViewController.h
//  Crystal
//
//  Created by Tom lu on 15/10/26.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HomePageViewController : BaseViewController


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


//顶部视图 包含了7个button
@property (strong, nonatomic) IBOutlet UIView * topView;
@property (strong, nonatomic) IBOutlet UIButton *button0;
@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@property (strong, nonatomic) IBOutlet UIButton *button6;

//广告的scrollView
@property (strong, nonatomic) IBOutlet UIScrollView *adScrollView;

//帖子部分
@property (strong, nonatomic) IBOutlet UITableView *postTableView;

//热门股票部分
@property (strong, nonatomic) IBOutlet UITableView *hotStockTableView;

//牛人部分
@property (strong, nonatomic) IBOutlet UITableView *bigManTableView;

@end
