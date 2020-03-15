//
//  ScheduleViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/25.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleTableViewCell.h"
#import "UIViewExt.h"
@interface ScheduleViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.width = SCREENWIDTH;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.height = SCREENHEIGHT - 64;
    self.tableView.delegate = (id)self;
    self.tableView.dataSource = (id)self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"ScheduleTableViewCell";
    UINib *nib=[UINib nibWithNibName:@"ScheduleTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    ScheduleTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ScheduleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
