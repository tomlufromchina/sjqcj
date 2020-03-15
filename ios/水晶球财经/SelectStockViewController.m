//
//  SelectStockViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/26.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "SelectStockViewController.h"
#import "UIViewExt.h"
@interface SelectStockViewController ()

@end

@implementation SelectStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我来选股";
    // Do any additional setup after loading the view from its nib.
    
    [self rebuildUI];
}


-(void)rebuildUI
{
    self.view.width = SCREENWIDTH;
    self.const0Label.width = self.constLabel1.width = self.constLabel2.width = self.constLabel3.width = self.tf0.width = self.tf1.width = self.tf2.width = self.tf3.width = SCREENWIDTH - 40;
    
    self.const0Label.left = self.constLabel1.left = self.constLabel2.left = self.constLabel3.left = self.tf0.left = self.tf1.left = self.tf2.left = self.tf3.left = 20;
    
    self.middleLine.width = SCREENWIDTH - 40;
    self.middleLine.height = 1;
    self.middleLine.backgroundColor = [UIColor grayColor];
    self.middleLine.left = 20;
    self.middleLine.top = self.tf1.bottom + 25;
    
    self.sureButton.left = 20;
    self.cancelButton.right = SCREENWIDTH - 20;
    
    self.sureButton.layer.cornerRadius = 8;
    self.cancelButton.layer.cornerRadius = 8;
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
