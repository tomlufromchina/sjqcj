//
//  AboutUsViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/6.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UIViewExt.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    self.view.backgroundColor = APPBackColor;
    // Do any additional setup after loading the view from its nib.
    
    self.textView.top = 10;
    self.textView.left = 10;
    self.textView.width = SCREENWIDTH - 20;
    self.textView.height = 400;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.textColor = [UIColor redColor];
    NSString* contentStr = [NSString stringWithFormat:@"        水晶球网隶属于四川水晶球网信息科技有限公司,水晶球财经网是一个为投资者服务的大型财经社交网络，由数名资深财经媒体人士及金融投资专家创办。去年上线以来，已经汇聚了一大批全国财经名人和证券牛人，每日出炉大量独具价值的财经资讯、原创证券分析以及实战操作记录，已成为全国广大证券投资者每日操作的重要指南和交流平台。水晶球财经网----中国最有价值的财经社区交流平台!　精华都在这里！"];
    self.textView.text = contentStr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
