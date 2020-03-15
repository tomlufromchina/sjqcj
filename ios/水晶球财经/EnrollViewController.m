//
//  EnrollViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/30.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "EnrollViewController.h"
#import "UIViewExt.h"
@interface EnrollViewController ()

@end

@implementation EnrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPBackColor;
    self.navigationItem.title = @"注册";
    // Do any additional setup after loading the view from its nib.
    self.view.width = SCREENWIDTH;
    self.const0Label.left = self.const1Label.left = 20;
    
    self.phoneNoLabel.centerX = self.passwordLabel.centerX = SCREENWIDTH * 0.5 + 20;
    self.const0Label.right = self.const1Label.right = self.phoneNoLabel.left;
    
    self.phoneNoLabel.backgroundColor = [UIColor lightGrayColor];
    self.passwordLabel.backgroundColor = [UIColor lightGrayColor];
    self.enrollButton.centerX = SCREENWIDTH* 0.5;
    self.enrollButton.top = self.const1Label.bottom + 60;
    
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
