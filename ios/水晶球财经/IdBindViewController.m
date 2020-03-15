//
//  IdBindViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/6.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "IdBindViewController.h"
#import "UIViewExt.h"
@interface IdBindViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray* _itemsArray;
}
@end

@implementation IdBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号绑定";
    self.view.backgroundColor = APPBackColor;
    // Do any additional setup after loading the view from its nib.
    [self initGlobleData];
    [self buildUI];
    
}
-(void)buildUI
{
    self.tableView.height = 360;
    self.tableView.width = SCREENWIDTH;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
}

-(void)initGlobleData
{
    _itemsArray = [[NSArray alloc]initWithObjects:@"",@"手机号",@"邮箱",@"新浪微博",@"微信",@"QQ", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"BindingCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row==0){
        cell.userInteractionEnabled = NO;
        cell.backgroundColor= APPBackColor;
    }else{
        cell.width = SCREENWIDTH;
        cell.textLabel.text = [_itemsArray objectAtIndex:indexPath.row];
        //创建label
        UILabel* label = [UILabel new];
        [cell addSubview:label];
        label.width = 150;
        label.height = 40;
        label.right = cell.width - 20;
        label.centerY = cell.height * 0.5 + 5;
        label.textColor = [UIColor orangeColor];
        if(indexPath.row==1){//手机号
            label.text = @"13788973456";
        }else if (indexPath.row==2){
            label.text = @"uis2be@yahu.com";
        }else if (indexPath.row==3){
            label.text = @"落叶孤城de微博";
        }else if (indexPath.row==4){
            label.text = @"me878kkl000bm";
        }else if(indexPath.row==5){
            label.text = @"136236012";
        }else{
            // do nothing
        }
    }
    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
