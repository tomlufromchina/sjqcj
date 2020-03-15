//
//  NewsViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "NewsViewController.h"
#import "UIViewExt.h"
#import "CommonMethod.h"
#import "AFNetworking.h"
#import "FinanceFocusListTableViewCell.h" //财经焦点cell
#import "FinanceFocusDetailViewController.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int _flag;  //标志，0，1，2 分别显示:滚动  财经  投资
    
    NSArray* _newsArray; //滚动新闻
    NSArray* _focusArray; //财经焦点
    NSArray* _investArray;  //投资日历
}
@end

@implementation NewsViewController
@synthesize segment;

-(void)viewDidAppear:(BOOL)animated
{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        //NSLog(@"顺序1--queue");
        [self requestFocusData]; //获取财经焦点数据
        [self requestNewsData];  //获取新闻数据
        [self requestInvestData];//获取投资日历数据
       
    });
    dispatch_group_async(group, queue, ^{
        // NSLog(@"顺序2--queue");
        [self.tableView reloadData];
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        //NSLog(@"顺序3--main");
        self.view.userInteractionEnabled = NO;
        [self show];
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        //NSLog(@"顺序4--main");
        self.view.userInteractionEnabled = YES;
    });

}


-(void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯首页";
    self.view.backgroundColor = APPBackColor;
    _flag = 1; //出来的时候tableview显示的是财经焦点数据
    // Do any additional setup after loading the view from its nib.
    [self buildUI];

    [self initGloableData];

}

-(void)buildUI
{
    segment.left = 5;
    segment.width = SCREENWIDTH - 200; //左右各留100
    segment.top = 10;
    segment.selectedSegmentIndex = 1;
    [segment setWidth:SCREENWIDTH -10]; //左右 各预留5
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.delegate = (id)self;
    self.tableView.dataSource = (id)self;
    
    self.tableView.top = segment.bottom+10;
    self.tableView.left = 0;
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT - self.tableView.top -66 - 49 ;// 首页  减去nav  减去 tabbar
    
}

-(void)initGloableData
{
    _newsArray = [[NSArray alloc]init];
    _focusArray = [[NSArray alloc]init];
    _investArray = [[NSArray alloc]init];
}

#pragma mark -- ====================网络请求====================
#pragma mark -- 滚动新闻 数据
-(void)requestNewsData
{
    NSString* url = [CommonMethod UrlAddAction:Url_GoodPost]; //CommonMethod.h
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:@"2" forKey:@"position"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if(jsonDic.count > 0){
            _newsArray = jsonDic[@"data"];
        }
        [self.tableView reloadData];
        //NSLog(@"滚动新闻返回数据：%@",_newsArray);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"滚动新闻请求错误%@",error);
        [self showError];
    }];
}


#pragma mark -- 财经焦点 数据
-(void)requestFocusData
{
    NSString* url = [CommonMethod UrlAddAction:Url_FinanceFocus];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic = [CommonMethod serializdDictionaryWithResponseObject:responseObject];
        //NSLog(@"%@",jsonDic);
        if([jsonDic[@"status"] isEqual:@1]){
            _focusArray = jsonDic[@"data"][@"news_style"];
           // NSLog(@"%@",_focusArray);
            [self.tableView reloadData];
            //[self showSuccess];
            [self dismiss];  // viewDidAppear中 必须show一下 这里不显示success
        }else{
            [self showError];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"财经焦点请求错误%@",error);
        [self showError];
    }];
}

#pragma mark -- 投资日历 数据
-(void)requestInvestData
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)segmentAction:(id)sender
{
    UISegmentedControl* tempSegment = (UISegmentedControl*)sender;
    NSInteger index = tempSegment.selectedSegmentIndex;
    switch (index) {
        case 0:
            _flag = 0;
            [self.tableView reloadData]; //后面改成请求数据
            break;
         case 1:
            _flag = 1;
             [self.tableView reloadData];//后面改成请求数据
            break;
        default:
            _flag = 2;
             [self.tableView reloadData];//后面改成请求数据
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_focusArray.count > 0){
        return _focusArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_flag==0){//滚动新闻
        UITableViewCell* cell0 = [UITableViewCell new];
        return cell0;
    }else if(_flag==1){ //财经焦点cell
        static NSString* identifier = @"financeFocusCell";
        UINib *nib=[UINib nibWithNibName:@"FinanceFocusListTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        FinanceFocusListTableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell1){
            cell1 = [[FinanceFocusListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if(_focusArray.count>0){
           NSDictionary* oneNews = [_focusArray objectAtIndex:indexPath.row];
            cell1.titleLabel.text = oneNews[@"news_title"];
            cell1.createTimeLabel.text = [CommonMethod getTimeStrWithTimeStamp:oneNews[@"created"]];
            
           
        }
        
        
        return cell1;
    }else{ //投资日历
        UITableViewCell* cell2 = [UITableViewCell new];
        return cell2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinanceFocusDetailViewController* detailVC = [FinanceFocusDetailViewController new];
    
    //如果id为空  那么不可以跳转
    detailVC.financeID = [[_focusArray objectAtIndex:indexPath.row] valueForKey:@"news_id"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
@end
