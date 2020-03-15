//
//  StockBarViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/12.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "StockBarViewController.h"
#import "UIViewExt.h"
#import "WeiBoTableViewCell.h" //微博cell
#import "AFNetworking.h"
#import "CommonMethod.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "OnePostDetailViewController.h"
#import "SelectEditeView.h"

#import "EditWeiBoViewController.h"//编辑长微博
#define LineColor RGB(197, 197, 198) //线条颜色
#define TopPostCellHeight 40   //置顶微博高度

#import "SEViewController.h" //编辑成微博新界面
#import "MJRefresh.h"  //拉动刷新


@interface StockBarViewController ()<UITableViewDelegate,UITableViewDataSource,SelectEditeViewDelegete>
{
    NSMutableArray* _allPostArray; //微博列表
    NSArray* _topPostArray;   //置顶帖
    int _pageIndex;
    
    SelectEditeView* _selectView;
}
@end

@implementation StockBarViewController


-(void)viewWillDisappear:(BOOL)animated
{
    if(_selectView){
        [_selectView removeFromSuperview];
        _selectView = nil;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        //NSLog(@"顺序1--queue");
        UIButton* pButton0 = (UIButton*)[self.headView viewWithTag:101];
        NSString* typeStr;
        if(pButton0.backgroundColor==[UIColor greenColor]){
            typeStr = @"all";
        }else{
            typeStr = @"following";
        }
        if(_allPostArray.count > 0){
            [_allPostArray removeAllObjects];
        }
        [self requestWeiBoData:@"1" type:typeStr]; //从位置1开始请求
        [self requestTopData]; //请求置顶微博信息
    });
    dispatch_group_async(group, queue, ^{
        int count = (int)[_topPostArray count];
        if(count>0){
            [self buildTopAndPostTable:count];
        }
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        self.view.userInteractionEnabled = NO;
        [self show];
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        self.view.userInteractionEnabled = YES;
    });
  
}
-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"股吧";
    //处理navBar
    //处理nav item
    UIBarButtonItem* rightSearchItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target: self action:@selector(ItemSearchAction)];
    
    UIView* emptyView = [UIView new];
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithCustomView:emptyView];
    
    UIBarButtonItem* rightEditItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(ItemEditAction)];
    
    self.navigationItem.rightBarButtonItems = @[rightEditItem,spaceItem,rightSearchItem];
    
    // Do any additional setup after loading the view from its nib.
    [self buildUI];
    [self initGloabelData];
    // 设置上拉 下拉刷新
    [self makeTableViewFresh];
    
}

-(void)buildUI
{
    //headView处理
    self.headView.width = SCREENWIDTH;
    self.headView.height = 50;
    self.headView.left = 0;
    self.headView.top = 0;
    
 #pragma mark --==================================================
    //全部
    UIButton* allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headView addSubview:allButton];
    allButton.width = SCREENWIDTH * 0.5;
    allButton.height = self.headView.height;
    allButton.left = 0;
    allButton.centerY = self.headView.height*0.5;
    [allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    allButton.tag = 101;
    allButton.backgroundColor = [UIColor greenColor];
    
    UIButton* label0 = [UIButton buttonWithType:UIButtonTypeCustom];
    label0.width = 60;
    label0.height = 40;
    [self.headView addSubview:label0];
    [label0 setTitle:@"全部" forState:UIControlStateNormal];
    [label0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    label0.centerY = 25;
    label0.centerX = SCREENWIDTH * 0.25;
    label0.userInteractionEnabled = NO;
    
    
    //关注
    UIButton* tentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headView addSubview:tentionButton];
    tentionButton.width = SCREENWIDTH * 0.5;
    tentionButton.height = self.headView.height;
    tentionButton.right = SCREENWIDTH;
    tentionButton.centerY = self.headView.height*0.5;
    tentionButton.tag = 102;
    tentionButton.backgroundColor = [UIColor clearColor];
    [tentionButton addTarget:self action:@selector(tentionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* label1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    label1.width = 40;
    label1.height = 60;
    [self.headView addSubview:label1];
    [label1 setTitle:@"关注" forState:UIControlStateNormal];
    [label1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    label1.centerY = 25;
    label1.centerX = SCREENWIDTH * 0.75;
    label1.userInteractionEnabled = NO;
    
    
    
    //中线
    UIView* middleLine = [UIView new];
    [self.headView addSubview:middleLine];
    middleLine.width = 1;
    middleLine.height = 50;
    middleLine.top = 0;
    middleLine.left = SCREENWIDTH * 0.5;
    middleLine.backgroundColor = LineColor;
    
    //底部横线
    UIView* bottomLine = [UIView new];
    [self.headView addSubview:bottomLine];
    bottomLine.width = SCREENWIDTH;
    bottomLine.height = 1;
    bottomLine.left = 0;
    bottomLine.top = self.headView.height-1;
    bottomLine.backgroundColor = LineColor;
    
    //处理置顶部分 + 微博tableview
    
    [self buildTopAndPostTable:0]; //开始时，置顶信息传递默认为0条
    
}

/* our request ID is: 102122-242494.*/
-(void)buildTopAndPostTable:(int)TopPostCount
{
    //处理置顶帖Tv
    self.topPostTableView.width = SCREENWIDTH;
    self.topPostTableView.height = TopPostCount * TopPostCellHeight;
    self.topPostTableView.left = 0;
    self.topPostTableView.top = self.headView.height+1;
    self.topPostTableView.delegate = self;
    self.topPostTableView.dataSource = self;
    self.topPostTableView.scrollEnabled = NO;
    self.topPostTableView.backgroundColor = [UIColor orangeColor];
    self.topPostTableView.separatorStyle = UITableViewCellSeparatorStyleNone; //取消分割线
    
    //处理微博内容Tv
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT-64-49-self.headView.height;
    [self.tableView setTableHeaderView:self.topPostTableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.left = 0;
    self.tableView.top = self.headView.height;
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //取消分割线
    
}

-(void)initGloabelData
{
    _allPostArray = [NSMutableArray new];
    _topPostArray =  [NSArray new];
    _pageIndex = 1;
    
}


#pragma mark --  上下拉动刷新
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
   //网络请求
    UIButton* pButton0 = [self.headView viewWithTag:101];
    NSString* typeStr;
    if(pButton0.backgroundColor==[UIColor greenColor]){
        typeStr = @"all";
    }else{
        typeStr = @"following";
    }
    [self requestWeiBoData:[NSString stringWithFormat:@"%d",_pageIndex] type:typeStr]; //从位置1开始请求
    [self requestTopData]; //请求置顶微博信息

    
}

//尾部刷新
-(void)footerRequestData
{
    _pageIndex++;
    
    //网络请求
    UIButton* pButton0 = [self.headView viewWithTag:101];
    NSString* typeStr;
    if(pButton0.backgroundColor==[UIColor greenColor]){
        typeStr = @"all";
    }else{
        typeStr = @"following";
    }
    [self requestWeiBoData:[NSString stringWithFormat:@"%d",_pageIndex] type:typeStr]; //从位置1开始请求
    [self requestTopData]; //请求置顶微博信息

}



#pragma mark -- 搜索响应
-(void)ItemSearchAction
{
    
}

//游风
#pragma mark -- 编辑响应
//编辑
-(void)ItemEditAction
{
    _selectView = [[SelectEditeView alloc]init];
    _selectView.delegete = (id)self;
    [self.view addSubview:_selectView];
    [_selectView setTag:1111];

}

#pragma mark -- 点击了全部
-(void)allButtonAction:(UIButton*)button
{
    if(button.backgroundColor ==[UIColor clearColor]){
        button.backgroundColor = [UIColor greenColor];
        UIButton* button1 = [self.headView viewWithTag:102];
        button1.backgroundColor = [UIColor clearColor];
        //网络请求
        [self show];
        [_allPostArray removeAllObjects];
        [self requestWeiBoData:@"1" type:@"all"];
    }else{
        //不做处理
    }
}
#pragma makr -- 点击了关注
-(void)tentionButtonAction:(UIButton*)button
{
    if(button.backgroundColor == [UIColor clearColor]){
        button.backgroundColor = [UIColor greenColor];
        
        UIButton* button0 = [self.headView viewWithTag:101];
        button0.backgroundColor = [UIColor clearColor];
        //网络请求
        [self show];
        [_allPostArray removeAllObjects];
        [self requestWeiBoData:@"1" type:@"following"];
    }else{
        //不做处理
    }
    
}


#pragma mark -- ==================网络请求================
#pragma mark -- 请求全部微博信息
-(void)requestWeiBoData:(NSString*)pageIndex
                   type:(NSString*)type
{
    NSString* url = [CommonMethod UrlAddAction:Url_Bar_Post_List]; //CommonMethod.h
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:pageIndex forKey:@"p"];
    [parameterDic setObject:type forKey:@"type"];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if(jsonDic.count > 0){
            NSArray* tempPostArray = jsonDic[@"data"];
            [_allPostArray addObjectsFromArray:tempPostArray];
            NSLog(@"%lu",_allPostArray.count);
        }
        [self.tableView reloadData];
        NSLog(@"股吧-微博列表返回数据：%@",_allPostArray);
        [self dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"微博列表返请求错误%@",error);  
        [self showError];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark -- 请求置顶信息
-(void)requestTopData  //请求置顶信息
{
    NSString* url = [CommonMethod UrlAddAction:Url_Bar_Top]; //CommonMethod.h
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    NSString* userId = [UserInfo sharedInfo].userId;
    if(!userId){
        [self showAlert:nil message:@"请先登录"];
        return;
    }
    [parameterDic setObject:userId forKey:@"mid"];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
       // NSLog(@"%@",jsonDic);
        if([jsonDic[@"status"] isEqual:@1]){
            _topPostArray = jsonDic[@"data"];
            [self.topPostTableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                int count = (int)[_topPostArray count];
                [self buildTopAndPostTable:count];
            });
           // NSLog(@"置顶微博表返回数据：%@",_topPostArray);
        }
        //[self dismiss];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"置顶帖列表返请求错误%@",error);
        [self showError];
    }];
    
}


#pragma mark -- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.topPostTableView){ //置顶微博
        return [_topPostArray count];
    }else{
       return [_allPostArray count]; //全部微博
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == self.topPostTableView){//置顶微博  cell 高度只有50
        UITableViewCell* cell = [UITableViewCell new];
       
        //处理置顶帖
        UIImageView* imageView = [UIImageView new];
        imageView.width = 30;
        imageView.height =15;
        [cell addSubview:imageView];
        imageView.left = 20;
        imageView.centerY = cell.height * 0.5;
        imageView.image = [UIImage imageNamed:@"置顶"];
        
        
        //处理时间
        UILabel* timeLabel = [UILabel new];
        timeLabel.width = 80;
        timeLabel.height = 40;
        [cell addSubview:timeLabel];
        timeLabel.centerY = cell.height * 0.5;
        timeLabel.right = SCREENWIDTH - 5;
        timeLabel.font = [UIFont systemFontOfSize:8];
        timeLabel.textColor = [UIColor blueColor];
       
        
        NSString* time = [[_topPostArray objectAtIndex:indexPath.row]valueForKey:@"ctime"];
        time = [CommonMethod getTimeStrWithTimeStamp:time];
        timeLabel.text = time;
        
        //处理标题
        UILabel* titleLabel = [UILabel new];
        titleLabel.width = SCREENWIDTH - imageView.right -10 - 10 - timeLabel.width-15 ;
        titleLabel.height = 40;
        titleLabel.left = imageView.right+10;
        [cell addSubview:titleLabel];
        titleLabel.centerY = cell.height * 0.5;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.text =[[_topPostArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        

        cell.layer.borderWidth = 1;
        cell.layer.borderColor = LineColor.CGColor;
        
        return cell;
    }else{ //全部微博
        NSString *identifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        UINib *nib=[UINib nibWithNibName:@"WeiBoTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        WeiBoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            cell = [[WeiBoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSDictionary* onePost = [_allPostArray objectAtIndex:indexPath.row];
        //NSLog(@"--->%@",onePost);
        //头像
        NSString* urlStr = [[onePost valueForKey:@"user_info"]valueForKey:@"avatar_big"];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
        //用户名
        NSString* name = [[onePost valueForKey:@"user_info"]valueForKey:@"uname"];
        cell.nameLabel.text = name;
      
        
        //内容   内容有时候 是空的 我靠
        cell.contentLabel.backgroundColor = RGB(240, 240, 242);
        NSString* content = [onePost valueForKey:@"content"];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[content  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}documentAttributes:nil error:nil];
              //内容显示
        cell.contentLabel.scrollEnabled = NO;
        cell.contentLabel.attributedText = attributedString;
        cell.contentLabel.height = [self getNewHeightForTextView:indexPath];
        
        /////////////////////增加多张图片开始/////////////////////
        UIView* bigForImageview = [self getBigViewAboutImagesForCell:indexPath];
       
        
        
        bigForImageview.backgroundColor = [UIColor clearColor];
        //NSLog(@"宽高：%f %f",bigForImageview.width,bigForImageview.height);
        [cell addSubview:bigForImageview];
        bigForImageview.top = cell.contentLabel.bottom;
        bigForImageview.left = cell.contentLabel.left;
       
        
        //在增加完这个View以后 ， 下面的 7个控件（时间， 转发*2， 点赞*2，发言*2） 都要移动
        // 这7个控件的移动代码，加在他们创建以后
        /////////////////////增加多张图片结束/////////////////////
        
        
        
        
        
        //创建时间
        NSString* time = [[onePost valueForKey:@"user_info"]valueForKey:@"ctime"];
        time = [CommonMethod getTimeStrWithTimeStamp:time];
        cell.timeLabel.text = time;
        
        //微博类型
        NSString* ID = [onePost valueForKey:@"feed_id"];
        //NSString* type = [onePost valueForKey:@"type"];
        //NSLog(@"微博类型=%@ 微博id=%@,名字=%@",type,ID,name);
        //转发量
        cell.no0Label.text =[NSString stringWithFormat:@"%@",[onePost valueForKey:@"repost_count"]];
        
        //点赞数
        NSString* goodCountStr = [onePost valueForKey:@"digg_count"];
        if([goodCountStr isEqual:[NSNull null]] || goodCountStr==nil){
            goodCountStr = @"0";
        }
        cell.no1Label.text =goodCountStr;
        
        //发帖数
        cell.no3Label.text =[NSString stringWithFormat:@"%@",[onePost valueForKey:@"comment_count"]];
        
        cell.backgroundColor = RGB(240, 240, 242);
        
     
        
        ///////////////////////////////////////////////代码片段添加开始
        //移动7个控件（时间， 转发*2， 点赞*2，发言*2）  还有最后那条线条 也要重新调整位置
        cell.timeLabel.top = 173 + bigForImageview.height;
        cell.relayButton.top = 156 + bigForImageview.height;
        cell.goodButton.top =156 + bigForImageview.height;
        cell.speakButton.top = 156 + bigForImageview.height;
        cell.no0Label.top = 182 + bigForImageview.height;
        cell.no1Label.top = 182 + bigForImageview.height;
        cell.no3Label.top = 182 + bigForImageview.height;
        cell.height = 200 + bigForImageview.height;
        cell.bottomLine.top = 199 + bigForImageview.height;
        ///////////////////////////////////////////////代码片段添加结束
       
        
        
        
        
        ///////////////////////////////////////////////
        //为cell中的三个button增加响应
         [cell setTag:ID.longLongValue];  //cell  == 微博ID
        
        [cell.relayButton addTarget:self action:@selector(relayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
         [cell.goodButton addTarget:self action:@selector(goodButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.speakButton addTarget:self action:@selector(speakButtonAction:) forControlEvents:UIControlEventTouchUpInside];
         
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.topPostTableView){ //置顶微博
        return TopPostCellHeight;
    }else{
        CGFloat bigViewHeight = [self getBigViewHeight:indexPath];   //临时变量  会自动析构
        return 200 + bigViewHeight; //全部微博
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OnePostDetailViewController* onePostVC = [OnePostDetailViewController new];
    
    NSString* feedId = [NSString new];
    
    if(tableView==self.tableView){//全部帖子
        feedId  = [[_allPostArray objectAtIndex:indexPath.row]valueForKey:@"feed_id"];
    }else{ //置顶贴
        feedId = [[_topPostArray objectAtIndex:indexPath.row]valueForKey:@"feed_id"];
    }
    onePostVC.feed_id = feedId ;
    if(!onePostVC.feed_id){
        NSLog(@"股吧，获取微博发生异常");
        return;
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:onePostVC animated:YES];
    
    
}

#pragma mark -- 转发，点赞 评论  响应

//转发
-(void)relayButtonAction:(id)sender
{
    //UIButton* button = (UIButton*)sender;
   // [self uploadReplayData:button.tag];
    
}

//点赞
-(void)goodButtonAction:(id)sender
{
    UIButton* pButton = (UIButton*)sender;
    WeiBoTableViewCell* pCell = (WeiBoTableViewCell*)[pButton superview].superview;
    NSString* feedID = [NSString stringWithFormat:@"%lu",pCell.tag];
    
    
    if(![UserInfo sharedInfo].userId){
        [self showAlert:nil message:@"请先登录"];
        return;
    }
    
    NSString* url = [CommonMethod UrlAddAction:Url_Post_Dig];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:feedID forKey:@"feed_id"]; //微博ID
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
       // NSLog(@"点赞信息返回数据%@",jsonDic);
        if([jsonDic[@"status"]isEqual:@1]){ //如果操作成功
            
            //处理button图片
            pButton.imageView.image = [UIImage imageNamed:@"已赞新"];
            
            //处理label
            NSString* beforCount = pCell.no1Label.text;
            int  intCount = beforCount.intValue;
            
            [pCell.no1Label setText:[NSString stringWithFormat:@"%d",intCount++]];
        

        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"点赞请求错误%@",error);
    }];

}

//评论
-(void)speakButtonAction:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提示框  这个方法 只能在当前类中使用
-(void)showAlert:(NSString*)title
         message:(NSString*)message
{
    if(title==nil){
        title = @"提示";
    }
    if(message==nil){
        message = @"正在开发...";
    }
    
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //点击取消的响应
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    //点击确定的响应
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    NSLog(@"touched");
}


#pragma makr -- 转发，点赞， 评论 网络请求

-(void)uploadReplayData:(int)ReplayNo
{
    NSString* url = [CommonMethod UrlAddAction:Url_Post_DeDig];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:@"" forKey:@"feed_id"]; //微博ID
    

    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
       // NSLog(@"点赞信息返回数据%@",jsonDic);
        [self.tableView reloadData];
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"精华帖请求错误%@",error);
    }];

}

#pragma mark -- 选择编辑界面代理方法

-(void)shortWeiBoBtnAction  //发短微博  用的是自定义VC
{
    EditWeiBoViewController* editVC = [EditWeiBoViewController new];
      editVC.title = @"短微博";
    self.hidesBottomBarWhenPushed = YES;
    [_selectView removeFromSuperview];
    _selectView = nil;
    [self.navigationController pushViewController:editVC animated:YES];
}

-(void)longWeiBoBtnAction //发长微博  用的是SEViewController
{
    SEViewController* editVC = [SEViewController new];
    editVC.title = @"长微博";
    editVC.editeStyle = EditeStyleLongWeiBo;
    self.hidesBottomBarWhenPushed = YES;
    [_selectView removeFromSuperview];
    _selectView = nil;
    [self.navigationController pushViewController:editVC animated:YES];
}

-(void)leaveBtnAction  //离开
{
    UIView* selectionView = [self.view viewWithTag:1111];
    [selectionView removeFromSuperview];
    selectionView = nil;
}

#pragma mark -- 辅助方法 ，根据内容， 获取textView 高度   最高高度80
-(CGFloat)getNewHeightForTextView:(NSIndexPath*)indexPath
{
     NSDictionary* onePost = [_allPostArray objectAtIndex:indexPath.row];
     NSString* content = [onePost valueForKey:@"content"]; //纯内容，没有图片
     NSString* html_str = content;
     NSString* oldPartStr = @"__THEME__";
     NSString* newPartStr = @"http://www.sjqcj.com/addons/theme/stv1/_static";
     NSString* newHtmlStr = [html_str stringByReplacingOccurrencesOfString:oldPartStr withString:newPartStr];
     NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[newHtmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
     UITextView* tempLabel = [UITextView new];
     tempLabel.width = SCREENWIDTH - 100;    //cell中textView的宽度
     tempLabel.height = 0;
    
     tempLabel.attributedText = attributedString;
     CGFloat newHeight = tempLabel.contentSize.height;
    if(newHeight > 60){
        newHeight = 80;
    }
    return newHeight;
}


#pragma makr -- 在cell中增加一张图片，图片中又若干imageView 最终返回若干图片所在的那个view  短微博专用
-(CGFloat)getBigViewHeight:(NSIndexPath*)indexPath
{
    UIView* bigView = [[UIView alloc]init];
    bigView.width = SCREENWIDTH - 100;  //和cell中textView的宽度一样
    
    NSDictionary* onePost = [_allPostArray objectAtIndex:indexPath.row];
    NSString* feed_type = [onePost valueForKey:@"type"]; //纯内容，没有图片
    if([feed_type isEqualToString:@"postimage"]){ //短微博带图片
        CGFloat constImageWidth = bigView.width * 0.333;
        
        NSArray* imageUrlArray = [onePost valueForKey:@"attach_url"];
        for(int i = 0; i < [imageUrlArray count]; i++){
            CGPoint currentImagePoint = [self getOriginalPointOfSmallImageInBigView:i];
            UIImageView* currentImageView = [UIImageView new];
            [bigView addSubview:currentImageView];
            currentImageView.width = currentImageView.height = constImageWidth;
            currentImageView.left = currentImagePoint.x * constImageWidth;
            currentImageView.top = currentImagePoint.y * constImageWidth;
            
            //显示图片
            NSString* imageUrlStr = [imageUrlArray objectAtIndex:i];
            imageUrlStr = [WeiBoImg stringByAppendingString:imageUrlStr];
            [currentImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
            bigView.height = currentImageView.bottom;  //多执行了几次 不过少些很多代码了
        } //for循环，根据图片url个数创建UIImageView
    }else{
        bigView.height = 0;
    }
    return bigView.height;

}

-(UIView*)getBigViewAboutImagesForCell:(NSIndexPath*)indexPath
{
    //先给出一个图片
    UIView* bigView = [[UIView alloc]init];
    bigView.width = SCREENWIDTH - 100;  //和cell中textView的宽度一样
    
    NSDictionary* onePost = [_allPostArray objectAtIndex:indexPath.row];
    NSString* feed_type = [onePost valueForKey:@"type"]; //纯内容，没有图片
    if([feed_type isEqualToString:@"postimage"]){ //短微博带图片
        CGFloat constImageWidth = bigView.width * 0.333;
        
        NSArray* imageUrlArray = [onePost valueForKey:@"attach_url"];
        for(int i = 0; i < [imageUrlArray count]; i++){
          CGPoint currentImagePoint = [self getOriginalPointOfSmallImageInBigView:i];
            UIImageView* currentImageView = [UIImageView new];
            [bigView addSubview:currentImageView];
            currentImageView.width = currentImageView.height = constImageWidth;
            currentImageView.left = currentImagePoint.x * constImageWidth +  (i%3);
            currentImageView.top = currentImagePoint.y * constImageWidth + (i%3);
            
            //显示图片
            NSString* imageUrlStr = [imageUrlArray objectAtIndex:i];
            imageUrlStr = [WeiBoImg stringByAppendingString:imageUrlStr];
            [currentImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
            bigView.height = currentImageView.bottom;  //多执行了几次 不过少些很多代码了
        } //for循环，根据图片url个数创建UIImageView
        
    }else{
        bigView.height = 0;
    }
   
    
    return bigView;
    
}

-(CGPoint)getOriginalPointOfSmallImageInBigView:(int)imageCount
{
    NSInteger flag = imageCount;
    CGPoint point;
    if(flag==0){
        point = CGPointMake(0, 0);
    }else if (flag==1){
        point = CGPointMake(1, 0);
    }else if (flag==2){
        point = CGPointMake(2, 0);
    }else if (flag==3){
        point = CGPointMake(0, 1);
    }else if (flag==4){
        point = CGPointMake(1, 1);
    }else if (flag==5){
        point = CGPointMake(2, 1);
    }else if (flag==6){
        point = CGPointMake(0, 2);
    }else if (flag==7){
        point = CGPointMake(1, 2);
    }else if (flag==8){
        point = CGPointMake(2, 2);
    }
    return point;
}


@end
