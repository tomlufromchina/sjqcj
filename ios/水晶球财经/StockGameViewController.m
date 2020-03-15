//
//  StockGameViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//
#import "StockGameViewController.h"
#import "UIViewExt.h"
#import "GameTableViewCell.h"
#import "UpDownViewController.h"
#import "ScheduleViewController.h"
#import "AFNetworking.h"
#import "CommonMethod.h"
#import "SelectStockViewController.h"
#import "GameMoreViewController.h"
#import "UIImageView+WebCache.h"
@interface StockGameViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray* _allFamous; // 名人组数据 保存全部
    NSArray* _allNice;   //精英组数据  保存全部
    
    NSMutableArray* _famousArray; //名人组数据 保存3条
    NSMutableArray* _niceArray;  //精英组数据  保存3条
    
    UIView* _headerView0;   // section0 header
    UIView* _headerView1;   // section1  header
}
@end

@implementation StockGameViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self show];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildRealTimeGame]; //实时赛况
    [self initGloableData];
    
}

-(void)buildRealTimeGame
{
    self.navigationItem.title = @"选股比赛";
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"我来选股" style:UIBarButtonItemStylePlain target:self action:@selector(buttonItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //头部view xib中设为为红色了
    self.headerView.width = SCREENWIDTH;
    self.headerView.left = 0;
    self.headerView.top = 0;
    
    //大背景1  包含四个按钮
    self.fourButtonView.width = SCREENWIDTH;
    self.fourButtonView.height = 52;
    self.fourButtonView.left = 0;
    self.fourButtonView.top = 0;
    
    //4个按钮
    self.button0.width = self.button1.width = self.button2.width = self.button3.width =(SCREENWIDTH - 3)* 0.25;
    self.button0.height = self.button1.height = self.button2.height = self.button3.height = 50;
    self.button0.top = self.button1.top = self.button2.top = self.button3.top = 1;
    self.button0.left = 0;
    self.button1.left = self.button0.right + 1;
    self.button2.left = self.button1.right + 1;
    self.button3.left = self.button2.right + 1;
    
        //为实时赛况按钮下方增加一跟线条
    UIView* line = [[UIView alloc]init];
    [self.button0 addSubview:line];
    line.width = self.button0.width ;
    line.height = 3;
    line.backgroundColor = [UIColor lightGrayColor];
    line.left = 0;
    line.bottom = self.button0.height ;
    
    [self.button0 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //大背景2 包含四个图片和label
    self.fourImageView.width =SCREENWIDTH;
    self.fourImageView.top = self.fourButtonView.bottom;
    
    //4个imageView 以及label
    self.image0.width = self.image1.width = self.image2.width = self.image3.width = self.image0.height = self.image1.height = self.image2.height = self.image3.height = self.button0.width * 0.8;
    self.image0.left = (SCREENWIDTH - self.image0.width*4) * 0.2;
    self.image1.left = self.image0.right + self.image0.left;
    self.image2.left = self.image1.right + self.image0.left;
    self.image3.left = self.image2.right + self.image0.left;
    
    self.label0.top = self.image0.bottom + 5;
    self.label1.top = self.image1.bottom + 5;
    self.label2.top = self.image2.bottom + 5;
    self.label3.top = self.image3.bottom + 5;
    self.label0.centerX = self.image0.centerX;
    self.label1.centerX = self.image1.centerX;
    self.label2.centerX = self.image2.centerX;
    self.label3.centerX = self.image3.centerX;
    
    UIButton* allScoreButton = [UIButton buttonWithType:UIButtonTypeCustom]; //增加到总积分榜
    [self.fourImageView addSubview:allScoreButton];
    allScoreButton.width = self.image0.width;
    allScoreButton.height = self.fourImageView.height;
    allScoreButton.left = SCREENWIDTH * 0.25 *0;
    allScoreButton.top = 0;
    [allScoreButton addTarget:self action:@selector(allScoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* weekScoreButton = [UIButton buttonWithType:UIButtonTypeCustom]; //增加到周积分榜
    [self.fourImageView addSubview:weekScoreButton];
    weekScoreButton.width = self.image0.width;
    weekScoreButton.height = self.fourImageView.height;
    weekScoreButton.left = SCREENWIDTH * 0.25 *1;
    weekScoreButton.top = 0;
    [weekScoreButton addTarget:self action:@selector(weekScoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* shortLineButton = [UIButton buttonWithType:UIButtonTypeCustom]; //增加到周积分榜
    [self.fourImageView addSubview:shortLineButton];
    shortLineButton.width = self.image0.width;
    shortLineButton.height = self.fourImageView.height;
    shortLineButton.left = SCREENWIDTH * 0.25 *2;
    shortLineButton.top = 0;
    [shortLineButton addTarget:self action:@selector(shortButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //重新设定大背景2的高度
    self.fourImageView.height = self.label0.bottom + 5;
    //header子元素创建结束了，根据子元素的高度，确定header的高度
    self.headerView.height = self.fourImageView.bottom;
    
    
    
    //设置tableView
    self.tableView.width =SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT - 64;
    self.tableView.top = 0;
    self.tableView.left = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTableHeaderView:self.headerView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}


-(void)initGloableData
{
    _allFamous = [NSArray new];
    _allNice = [NSArray new];
    
    _famousArray = [NSMutableArray new];
    _niceArray = [NSMutableArray new];
}
#pragma mark -- ================网络请求================
-(void)requestData
{
    //Url_Function_StockGame
    NSString* url = [CommonMethod UrlAddAction:Url_Function_StockGame];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic = [CommonMethod serializdDictionaryWithResponseObject:responseObject];
       
        
        NSLog(@"%@",jsonDic);
        if([jsonDic[@"status"] isEqual:@1]){
            _allNice= [jsonDic[@"data"]valueForKey:@"ballot1"]; //精英组 最新
            for(int i = 0; i < 3; i++){
                [_niceArray addObject:[_allNice objectAtIndex:i]];
            }
            
            _allFamous = [jsonDic[@"data"]valueForKey:@"ballot2"]; //名人组，最新
            for(int i = 0; i < 3;i++){
                [_famousArray addObject:[_allFamous objectAtIndex:i]];
            }
            [self.tableView reloadData];
        } //状态码==1结束
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"选股比赛请求错误%@",error);
        [self showError];
    }];

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
#pragma mark -- barButtonItem 响应
-(void)buttonItemAction
{
    SelectStockViewController* VC = [SelectStockViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma makr -- tabelView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //headerView0==================
    _headerView0 = [[UIView alloc]init];
    _headerView0.width = SCREENWIDTH;
    _headerView0.height = 50;
    _headerView0.backgroundColor = [UIColor grayColor];
    
    UILabel* label0 = [UILabel new];
    [_headerView0 addSubview:label0];
    
    label0.width = 200;
    label0.height = 30;
    label0.left = 10;
    label0.top = 0;
    label0.text = @"名人组实时赛况(第五周)";
    
    UILabel* label1 = [UILabel new];
    [_headerView0 addSubview:label1];
    label1.width = 40;
    label1.height = 30;
    label1.right = SCREENWIDTH - 20;
    label1.top = 0;
    label1.text = @"更多";
    label1.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreLabelAction1)];
    [label1 addGestureRecognizer:tap0];
    
    //headerView1=====================
    _headerView1 = [[UIView alloc]init];
    _headerView1.width = SCREENWIDTH;
    _headerView1.height = 50;
    _headerView1.backgroundColor = [UIColor grayColor];
    
    UILabel* label10 = [UILabel new];
    [_headerView1 addSubview:label10];
    
    label10.width = 200;
    label10.height = 30;
    label10.left = 10;
    label10.top = 0;
    label10.text = @"精英组组实时赛况(第五周)";
    
    UILabel* label11 = [UILabel new];
    [_headerView1 addSubview:label11];
    label11.width = 40;
    label11.height = 30;
    label11.right = SCREENWIDTH - 20;
    label11.top = 0;
    label11.text = @"更多";
    label11.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreLabelAction2)];
    [label11 addGestureRecognizer:tap1];
    
    if(section==0){
        return _headerView0;
    }else{
        return _headerView1;
    }
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

    if(indexPath.section==0){  //名人组
        if([_famousArray count]>0){
            NSDictionary* onePerson = [_famousArray objectAtIndex:indexPath.row];
            //排名
            cell.rankLabel.text = [NSString stringWithFormat:@"%lu",indexPath.row + 1];
            //名字
            NSString* headName = [onePerson valueForKey:@"uname"];
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",headName];
            
            //头像
            NSString* headUrlStr = [onePerson valueForKey:@"image"];
            headUrlStr = [MainImg stringByAppendingString:headUrlStr];
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:headUrlStr]];
            
            //周数
            NSString* weekCount = [onePerson valueForKey:@"weekly"];
            int IntValue =  weekCount.intValue;
            cell.weekCountLabel.text = [NSString stringWithFormat:@"%d",IntValue+1];
            //周积分
            NSString* week = [onePerson valueForKey:@"integration"];
            cell.weekScoreLabel.text = [NSString stringWithFormat:@"%@",week];
            //总积分
            NSString* all = [onePerson valueForKey:@"ballot_jifen"];
            cell.allScoreLabel.text = [NSString stringWithFormat:@"%@",all];
            //股票0
            NSString* name = [onePerson valueForKey:@"shares_name"];
            cell.stockNameLabel.text = [NSString stringWithFormat:@"%@",name];
            //最新价格0
            NSString* pice0 = [onePerson valueForKey:@"price"];
            cell.newestPricesLabel.text =[NSString stringWithFormat:@"%@",pice0];
            //涨跌幅0
            NSString* undown= [onePerson valueForKey:@"integration1"];
            cell.updownLabel.text = [NSString stringWithFormat:@"%@",undown];
            
            //股票1
            NSString* name2 = [onePerson valueForKey:@"shares2_name"];
            cell.stockNameLabel1.text = [NSString stringWithFormat:@"%@",name2];
            //最新价格1
            NSString* price2 = [onePerson valueForKey:@"price2"];
            cell.newestPricesLabel1.text = [NSString stringWithFormat:@"%@",price2];
            //涨跌幅1
            NSString* undown2 = [onePerson valueForKey:@"integration2"];
            cell.updownLabel1.text = [NSString stringWithFormat:@"%@",undown2];
        }
       
        
    }else{ //精英组
        
        if([_niceArray count]>0){
            NSDictionary* onePerson = [_niceArray objectAtIndex:indexPath.row];
            //排名
            cell.rankLabel.text = [NSString stringWithFormat:@"%lu",indexPath.row + 1];
            //名字
            NSString* headName = [onePerson valueForKey:@"uname"];
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",headName];
            //周积分
            NSString* week = [onePerson valueForKey:@"list_price"];
            cell.weekScoreLabel.text = [NSString stringWithFormat:@"%@",week];
            
            //头像
            NSString* headUrlStr = [onePerson valueForKey:@"image"];
            headUrlStr = [MainImg stringByAppendingString:headUrlStr];
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:headUrlStr]];
            
            //总积分
            NSString* all = [onePerson valueForKey:@"ballot_jifen"];
            cell.allScoreLabel.text = [NSString stringWithFormat:@"%@",all];
            //股票0
            NSString* name = [onePerson valueForKey:@"shares_name"];
            cell.stockNameLabel.text = [NSString stringWithFormat:@"%@",name];
            //最新价格0
            NSString* pice0 = [onePerson valueForKey:@"price"];
            cell.newestPricesLabel.text =[NSString stringWithFormat:@"%@",pice0];
            //涨跌幅0
            NSString* undown= [onePerson valueForKey:@"integration1"];
            cell.updownLabel.text = [NSString stringWithFormat:@"%@",undown];
            
            //股票1
            NSString* name2 = [onePerson valueForKey:@"shares2_name"];
            cell.stockNameLabel1.text = [NSString stringWithFormat:@"%@",name2];
            //最新价格1
            NSString* price2 = [onePerson valueForKey:@"price2"];
            cell.newestPricesLabel1.text = [NSString stringWithFormat:@"%@",price2];
            //涨跌幅1
            NSString* undown2 = [onePerson valueForKey:@"integration2"];
            cell.updownLabel1.text = [NSString stringWithFormat:@"%@",undown2];
        }
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark -- 顶部4个按钮响应  实时赛况，当日涨幅，赛程报道，讨论区
-(void)buttonAction:(id)sender
{
    UIButton* pButton = (UIButton*)sender;
    if([pButton isEqual:self.button0]){ // 实时赛况，就是当前页面。。。 设计错误啊
        NSLog(@"0");
       
    }else if([pButton isEqual:self.button1]){  //当日涨幅榜
        UpDownViewController* VC = [[UpDownViewController alloc]init];
        VC.title = @"当日涨幅榜";
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if([pButton isEqual:self.button2]){   //赛程报道
        ScheduleViewController* VC = [ScheduleViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if([pButton isEqual:self.button3]){    //讨论区
        NSLog(@"3");
       
    }
}

#pragma mark -- 总积分榜， 周积分榜 ， 短线榜， 人气榜 响应
-(void)allScoreButtonAction
{
    UpDownViewController* VC = [UpDownViewController new];
    self.hidesBottomBarWhenPushed = YES;
    VC.title = @"总积分榜";
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)weekScoreButtonAction
{
    UpDownViewController* VC = [UpDownViewController new];
    self.hidesBottomBarWhenPushed = YES;
    VC.title = @"周积分榜";
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)shortButtonAction
{
    UpDownViewController* VC = [UpDownViewController new];
    self.hidesBottomBarWhenPushed = YES;
    VC.title = @"短线榜";
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark -- 更多 点击操作   金鹰组

-(void)moreLabelAction1
{
    GameMoreViewController* moreVC = [GameMoreViewController new];
    self.hidesBottomBarWhenPushed = YES;
    moreVC.itemsArray = _allFamous;
    moreVC.title = @"名人组实时赛况";
    [self.navigationController pushViewController:moreVC animated:YES];
}
-(void)moreLabelAction2
{
    GameMoreViewController* moreVC = [GameMoreViewController new];
    self.hidesBottomBarWhenPushed = YES;
    moreVC.itemsArray = _allNice;
    moreVC.title = @"精英组实时赛况";
    [self.navigationController pushViewController:moreVC animated:YES];
}

@end






