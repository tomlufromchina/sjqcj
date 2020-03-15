//
//  PostListViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.

#import "PostListViewController.h"
#import "UIViewExt.h"
#import "NicePostTableViewCell.h"

#import "OnePostDetailViewController.h"
#import "AFNetworking.h"
#import "CommonMethod.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"


#define Url_GetImage   @"http://www.sjqcj.com/data/upload/" //精华微博列表 图片获取
#define Url_GetImage1  @"http://www.sjqcj.com/data/upload/avatar"  //牛人列表 图片获取
#define ImageXX        @"original_200_200.jpg" //牛人列表图片200*200
#define ImageLL        @"original_100_100.jpg"//100*100
#define ImageSS        @"original_50_50.jpg"  //50*50
#define Imagess        @"original_30_30.jpg"  //30*30

@interface PostListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _allPostArray; //全部精华帖
    
    int _pageIndex;
    int _buttonIndex; //点击了哪个按钮
}

@end

@implementation PostListViewController


-(void)viewDidAppear:(BOOL)animated
{
    [self show];
    [self requestPostListData:_pageIndex buttonIndex:_buttonIndex]; //2对应的是精华
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"精华";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.width = SCREENWIDTH;
    
    self.topLineView.top = 0;
    self.topLineView.left = 0;
    self.topLineView.width = self.view.width;
    self.topLineView.backgroundColor = [UIColor lightGrayColor];
    
    self.allButton.width = self.bigPanButton.width = self.someStockButton.width = self.lunDaoButton.width = self.famousButton.width = self.fuShengButton.width = 50;
    self.allButton.height = self.bigPanButton.height = self.someStockButton.height = self.lunDaoButton.height = self.famousButton.height = self.fuShengButton.height = 20;
    self.allButton.top = self.bigPanButton.top = self.someStockButton.top = self.lunDaoButton.top = self.famousButton.top = self.fuShengButton.top = self.topLineView.bottom + 5;
    
    self.allButton.left = (SCREENWIDTH-300) * 0.1428;
    self.bigPanButton.left = self.allButton.right + self.allButton.left;
    self.someStockButton.left = self.bigPanButton.right + self.allButton.left;
    self.lunDaoButton.left = self.someStockButton.right + self.allButton.left;
    self.famousButton.left = self.lunDaoButton.right + self.allButton.left;
    self.fuShengButton.left = self.famousButton.right + self.allButton.left;
    
    self.allButton.tag = 2;
    self.bigPanButton.tag = 3;
    self.someStockButton.tag = 4;
    self.lunDaoButton.tag = 5;
    self.famousButton.tag = 6;
    self.fuShengButton.tag = 7;
    
    [self.allButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bigPanButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.someStockButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.lunDaoButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.famousButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fuShengButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.lineView.top = self.famousButton.bottom+5;
    self.lineView.left = 0;
    self.lineView.width = SCREENWIDTH;
    self.lineView.backgroundColor  = [UIColor lightGrayColor];
    
    self.tableView.left = 0;
    self.tableView.top = self.lineView.bottom ;
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT - self.lineView.bottom -10 -66 ;
    self.tableView.delegate = (id)self;
    self.tableView.dataSource = (id)self;
    
   
    
    //数据处理相关了
    [self initGloableData];
    
   // 设置上拉 下拉刷新
    [self makeTableViewFresh];
    
   
}

-(void)makeTableViewFresh
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置header刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRequestData];
    }];
    
    // 设置footer尾部刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerRequestData];
    }];
}

//头部刷新
-(void)headerRequestData
{
    _pageIndex=1;
    if([_allPostArray count]>0){
        [_allPostArray removeAllObjects];
    }
    [self requestPostListData:_pageIndex buttonIndex:_buttonIndex];
}


//尾部刷新
-(void)footerRequestData
{
    _pageIndex++;
    [self requestPostListData:_pageIndex buttonIndex:_buttonIndex];
}


-(void)initGloableData
{
    _allPostArray = [NSMutableArray new];
   
    _pageIndex = 1;
    _buttonIndex = 2;  //从全部开始显示
}


-(void)requestPostListData:(int)pageIndex
               buttonIndex:(int)buttonIndex //2 - 7对应 全部- 浮生
{
    NSString* url = [CommonMethod UrlAddAction:Url_GoodPost];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    
    [parameterDic setObject:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"p"];
    if(pageIndex !=1){
        [parameterDic setObject:[NSString stringWithFormat:@"%d",buttonIndex] forKey:@"category"];
    
    }if(pageIndex==1){
        [parameterDic setObject:@"2" forKey:@"position"];
    }
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        NSArray* sectionPostArray = jsonDic[@"data"];
        [_allPostArray addObjectsFromArray:sectionPostArray];
        [self.tableView reloadData];
        NSLog(@"精华帖返回数据：%@",_allPostArray);
        [self dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"精华帖请求错误%@",error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];

}
#pragma mark -- tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allPostArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier0 = @"xibCell0";
    UINib *nib=[UINib nibWithNibName:@"NicePostTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier0];
    NicePostTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:identifier0];
    if(!cell0){
        cell0 = [[NicePostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
    }
    if(_allPostArray.count > 0){
        //头像图片处理
        NSString* endStr = [[_allPostArray objectAtIndex:indexPath.row]valueForKey:@"save_name"];
        NSString* middleStr = [[_allPostArray objectAtIndex:indexPath.row]valueForKey:@"save_path"];
        NSString* imageUrlStr = [NSString stringWithFormat:@"%@%@%@",Url_GetImage,middleStr,endStr];
        NSURL* imageUrl = [NSURL URLWithString:imageUrlStr];
        [cell0.headImageView sd_setImageWithURL:imageUrl];
        cell0.headImageView.width = cell0.headImageView.height* 1.3;
        //微博用户名
        cell0.authorLabel.text = [[_allPostArray objectAtIndex:indexPath.row]valueForKey:@"uname"];
        //微博标题
        cell0.titleLabel.text = [[_allPostArray objectAtIndex:indexPath.row]valueForKey:@"weibo_title"];
        //评论数
        cell0.commentCountLabel.text =[[_allPostArray objectAtIndex:indexPath.row]valueForKey:@"comment_count"];
    }
    
    return cell0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//跳转到帖子详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OnePostDetailViewController* detailVC = [OnePostDetailViewController new];
    detailVC.feed_id = [[_allPostArray objectAtIndex:indexPath.row]valueForKey:@"feed_id"];
    if(!detailVC.feed_id){
        [self.tableView reloadData];
        return;
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 顶部按钮响应
-(void)topButtonAction:(UIButton*)sender
{
    int index = (int)sender.tag;
    CGRect oldTableViewFrame = CGRectMake(self.tableView.left, self.tableView.height, self.tableView.width, self.tableView.height);
    self.tableView = nil;  //销毁tabelView  重新创建
    [_allPostArray removeAllObjects];
    [self requestPostListData:_pageIndex buttonIndex:index];
}
@end
