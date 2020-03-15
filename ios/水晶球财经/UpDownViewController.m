//
//  UpDownViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/25.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "UpDownViewController.h"
#import "UIViewExt.h"
#import "GameTableViewCell.h"

#define kHeaderViewHeightForTable  50.0     //tableview header的高度
@interface UpDownViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UpDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.width = SCREENWIDTH;
    self.scrollView.height = SCREENHEIGHT - 64;
    
    
    self.famousTableView.delegate = (id)self;
    self.famousTableView.dataSource = (id)self;
    
    self.goodTableView.delegate = (id)self;
    self.goodTableView.dataSource = (id)self;
    
    self.famousTableView.scrollEnabled = NO;
    self.goodTableView.scrollEnabled = NO;
    
    [self rebuildUI:3 count:3];  //多次会调用这个方法
}

-(void)rebuildUI:(int)countForTableView0    //名人组数据个数
           count:(int)countForTableView1;   //精英组数据个数
{
   
    self.topView0.left = 0;
    self.topView0.top = 0;
    self.topView0.width = SCREENWIDTH;
    self.topView0.backgroundColor = RGB(240, 240, 242);
    self.topView0.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topView0.layer.borderWidth = 1;
    
    self.famousTableView.top = self.topView0.bottom;
    self.famousTableView.left = 0;
    self.famousTableView.width = SCREENWIDTH;  //这些语句本来可以放在rebuildUI外面执行，但是为了方便看代码，就不放在外面了
    self.famousTableView.height =  kHeaderViewHeightForTable + 200 * countForTableView0;
    
    
    // header For tableView 0
    UIView* header0 = [UIView new];
    [self.scrollView addSubview:header0];
    header0.width = SCREENWIDTH;
    header0.height = kHeaderViewHeightForTable;
    header0.backgroundColor = [UIColor lightGrayColor];
    UILabel*label0 = [UILabel new];
    [header0 addSubview:label0];
    label0.width = 200;
    label0.height = 30;
    label0.top = 10;
    label0.left = 10;
    label0.text = @"名人组当日涨幅榜";
    UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [header0 addSubview:moreButton];
    moreButton.width = 50;
    moreButton.height = 50;
    moreButton.right = SCREENWIDTH;
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    self.famousTableView.tableHeaderView = header0;
    
   

    
    self.topView1.top = self.famousTableView.bottom;
    self.topView1.left = 0;
    self.topView1.width = SCREENWIDTH;
    self.topView1.backgroundColor = RGB(240, 240, 242);
    self.topView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topView1.layer.borderWidth = 1;
    
    
    self.goodTableView.top = self.topView1.bottom;
    self.goodTableView.left = 0;
    self.goodTableView.width = SCREENWIDTH;
    self.goodTableView.height = kHeaderViewHeightForTable + 160 * countForTableView1;
   
    // header For tableView 1
    UIView* header1 = [UIView new];
    [self.scrollView addSubview:header1];
    header1.width = SCREENWIDTH;
    header1.height = kHeaderViewHeightForTable;
    header1.backgroundColor = [UIColor lightGrayColor];
    UILabel*label10 = [UILabel new];
    [header1 addSubview:label10];
    label10.width = 200;
    label10.height = 30;
    label10.top = 10;
    label10.left = 10;
    label10.text = @"精英组当日涨幅榜";
    UIButton* moreButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [header1 addSubview:moreButton2];
    moreButton2.width = 50;
    moreButton2.height = 50;
    moreButton2.right = SCREENWIDTH;
    [moreButton2 setTitle:@"更多" forState:UIControlStateNormal];
    self.goodTableView.tableHeaderView = header1;
    
    
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, self.goodTableView.bottom);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableviw delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"GameTableViewCell";
    UINib *nib=[UINib nibWithNibName:@"GameTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    GameTableViewCell* cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[GameTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
