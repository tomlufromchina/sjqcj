//
//  HomePageViewController.m
//  Crystal
//
//  Created by Tom lu on 15/10/26.
//  Copyright © 2015年 com.sjqcj. All rights reserved.


#import "HomePageViewController.h"
#import "LoginViewController.h"
#import "UIViewExt.h"
#import "NicePostTableViewCell.h" //精华帖
#import "HotStockTableViewCell.h" //热门股
#import "BigManTableViewCell.h" //牛人

#import "NewsContentViewController.h"//新闻内容
#import "PostListViewController.h" //精华帖 列表
#import "OnePostDetailViewController.h" //某一个帖子的详情

#import "HotStockListViewController.h"   //热门股票列表
#import "OneStockViewController.h" //跳到一个股票详情

#import "BigManListViewController.h"//跳转到牛人列表中
#import "UserCenterViewController.h"

#import "AFNetworking.h"
#import "CommonMethod.h"

#import "UIImageView+WebCache.h" //图片缓存
#import "UserInfo.h"
#import "ViewController.h" //游戏界面
#import "StockGameViewController.h"//跳转到选股比赛

#define Url_GetImage   @"http://www.sjqcj.com/data/upload/" //精华微博列表 图片获取

#define Url_GetImage1  @"http://www.sjqcj.com/data/upload/avatar"  //牛人列表 图片获取
#define ImageXX        @"original_200_200.jpg" //牛人列表图片200*200
#define ImageLL        @"original_100_100.jpg"//100*100
#define ImageSS        @"original_50_50.jpg"  //50*50
#define Imagess        @"original_30_30.jpg"  //30*30

@interface HomePageViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITapGestureRecognizer* _tap0;
    UITapGestureRecognizer* _tap1;
    UITapGestureRecognizer* _tap2;
    
    long _timeStamp;  //全局的时间戳
    NSArray* _nicePostArray; //精华帖数据
    NSMutableArray* _nicePostTop3Array;//前三条数据
    
    
    NSArray* _bigManArray;  //牛人列表数据
    NSMutableArray* _bigManTop3Array;//前三条数据
    
   
}
@end

@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated   //两次进入这个方法
{

}


-(void)viewDidAppear:(BOOL)animated//  解决： 显示hud问题   解决：超级快速地点击cell同时，但数据还没有加载成功的问题
{
    
    //这个group 中的任务： 优先级1.自定义队列任务先执行，main队列后执行，  优先级2.从上往下降低。
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        //NSLog(@"顺序1--queue");
        [self requestGoodPostData]; //获取精华帖列表
        [self requestBigManData];//获取牛人列表
    });
    dispatch_group_async(group, queue, ^{
       // NSLog(@"顺序2--queue");
        [self.postTableView reloadData];
        [self.bigManTableView reloadData];
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

-(void)viewWillDisappear:(BOOL)animated  //执行顺序 1
{
    [super viewWillDisappear:animated];
     self.hidesBottomBarWhenPushed = NO;
}




- (void)viewDidLoad   // 执行顺序  0
{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.scrollView.backgroundColor = APPBackColor;
    // Do any additional setup after loading the view from its nib.
    [self buildUI];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    
    
    
    if([self isLogin]==NO){
        [self goLogin];
    }
    
    
    [self initGlobalMenbers]; //初始化全局成员变量
    
}



-(void)dealloc
{
   
}

-(void)buildUI
{
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    //第一部分，多个按钮
    self.topView.width = SCREENWIDTH;
    self.topView.height = SCREENWIDTH* 0.4;
    self.topView.backgroundColor = RGB(240, 240, 242);
    self.button0.width = self.button0.height = 50;
    self.button0.left = (SCREENWIDTH - 150) * 0.25;
    self.button0.top = 10;
    [self.button0 setTag:0];
    
    self.button1.top = self.button2.top = self.button2.top = self.button0.top;
    self.button1.left = self.button0.right + self.button0.left;
    self.button2.left = self.button1.right + self.button0.left;
    [self.button1 setTag:1];
    [self.button2 setTag:2];
    
    self.button3.top = self.button0.bottom + 10;
    self.button3.left = (SCREENWIDTH - 200)*0.2;
    [self.button3 setTag:3];
    
    self.button4.top = self.button5.top = self.button6.top = self.button3.top;
    self.button4.left = self.button3.right + self.button3.left;
    self.button5.left = self.button4.right + self.button3.left;
    self.button6.left = self.button5.right + self.button3.left;
    
    [self.button4 setTag:4];
    [self.button5 setTag:5];
    [self.button6 setTag:6];
    
    [self.button0 addTarget:self action:@selector(topButton0Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self action:@selector(topButton1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(topButton2Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self action:@selector(topButton3Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.button4 addTarget:self action:@selector(topButton4Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.button5 addTarget:self action:@selector(topButton5Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.button6 addTarget:self action:@selector(topButton6Action:) forControlEvents:UIControlEventTouchUpInside];
    
    //广告轮播图
    self.adScrollView.width = SCREENWIDTH;
    self.adScrollView.height = SCREENWIDTH * 0.4;
    self.adScrollView.top = self.topView.bottom + 5;
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    self.adScrollView.showsHorizontalScrollIndicator = YES;
    self.adScrollView.scrollEnabled = YES;
    self.adScrollView.pagingEnabled = YES;
    self.adScrollView.contentSize = CGSizeMake(SCREENWIDTH*3, self.adScrollView.height);
    for(int i = 0; i < 3; i++){
        UIImageView* imageView = [UIImageView new];
        [imageView setFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, self.adScrollView.height)];
        NSString* imageName = [NSString stringWithFormat:@"ad_%d",i];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.userInteractionEnabled = YES;
        [imageView setTag:i];
        if(0==i){
            _tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
            [imageView addGestureRecognizer:_tap0];
        }else if (1 == i){
            _tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
            [imageView addGestureRecognizer:_tap1];
        }else{ //i==2
            _tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
            [imageView addGestureRecognizer:_tap2];
        }
        [self.adScrollView addSubview:imageView];
    }
    
    //////////////////////帖子部分
    self.postTableView.top = self.adScrollView.bottom + 5;
    self.postTableView.width = SCREENWIDTH;
    self.postTableView.height = 440; //包括5个cell 400  + header 40
    self.postTableView.scrollEnabled = NO;
    self.postTableView.delegate = self;
    self.postTableView.dataSource = self;
             //headerView
    UIView* postHeaderView = [UIView new];
    [postHeaderView setFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];  //这里 从60改为了40
    postHeaderView.backgroundColor = RGB(120, 144, 134);
    [self.postTableView setTableHeaderView:postHeaderView];
    
                         //精华
    UIButton* niceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [niceButton setFrame:CGRectMake(0, 0, 80, 40)];
   // niceButton.backgroundColor = RGB(118, 235, 237);
    [niceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [niceButton setTitle:@"微博精华" forState:UIControlStateNormal];
    [postHeaderView addSubview:niceButton];
    niceButton.centerY = postHeaderView.height * 0.5;
    niceButton.left = 20;
                        //更多
    UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setFrame:CGRectMake(0, 0, 40, 40)];
    moreButton.backgroundColor = RGB(243, 168, 64);
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [postHeaderView addSubview:moreButton];
    moreButton.centerY = postHeaderView.height * 0.5;
    moreButton.right = postHeaderView.width - 20;
    [moreButton addTarget:self action:@selector(MorePostButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //////////////////////热门股票部分
    self.hotStockTableView.top = self.postTableView.bottom;
    self.hotStockTableView.height = 340; //3*100 + 40
    self.hotStockTableView.width = SCREENWIDTH;
    self.hotStockTableView.scrollEnabled = NO;
    self.hotStockTableView.delegate = self;
    self.hotStockTableView.dataSource = self;
       //headerView
    UIView* hotStockHeaderView = [UIView new];
    [hotStockHeaderView setFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    hotStockHeaderView.backgroundColor =  RGB(120, 144, 134);
    [self.hotStockTableView setTableHeaderView:hotStockHeaderView];
    
#pragma mark -- begin
    //热门股
    UIButton* hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotButton setFrame:CGRectMake(0, 0, 60, 40)];
   // hotButton.backgroundColor = RGB(118, 235, 237);
    [hotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [hotButton setTitle:@"热门股" forState:UIControlStateNormal];
    [hotStockHeaderView addSubview:hotButton];
    hotButton.centerY = hotStockHeaderView.height * 0.5;
    hotButton.left = 20;
    
    //更多
    UIButton* moreButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton1 setFrame:CGRectMake(0, 0, 40, 40)];
    moreButton1.backgroundColor = RGB(243, 168, 64);
    [moreButton1 setTitle:@"更多" forState:UIControlStateNormal];
    [hotStockHeaderView addSubview:moreButton1];
    [moreButton1 addTarget:self action:@selector(moreStockButtonAction) forControlEvents:UIControlEventTouchUpInside];
    moreButton1.centerY = hotStockHeaderView.height * 0.5;
    moreButton1.right = hotStockHeaderView.width - 20;
#pragma mark -- end
    
    
    
    
    
    //////////////////////牛人部分
    self.bigManTableView.top = self.hotStockTableView.bottom;
    self.bigManTableView.height = 340; //3*100+40
    self.bigManTableView.width = SCREENWIDTH;
    self.bigManTableView.scrollEnabled = NO;
    self.bigManTableView.delegate = self;
    self.bigManTableView.dataSource = self;
    //headerView
    UIView* bigManHeaderView = [UIView new];
    [bigManHeaderView setFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    bigManHeaderView.backgroundColor =  RGB(120, 144, 134);
    [self.bigManTableView setTableHeaderView:bigManHeaderView];
#pragma mark -- begin
    //牛人
    UIButton* bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bigButton setFrame:CGRectMake(0, 0, 60, 40)];
   // bigButton.backgroundColor = RGB(118, 235, 237);
    [bigButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bigButton setTitle:@"牛人" forState:UIControlStateNormal];
    [bigManHeaderView addSubview:bigButton];
    bigButton.centerY = hotStockHeaderView.height * 0.5;
    bigButton.left = 20;
    
    //更多
    UIButton* moreButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton2 setFrame:CGRectMake(0, 0, 40, 40)];   //50改为40
    moreButton2.backgroundColor = RGB(243, 168, 64);
    [moreButton2 setTitle:@"更多" forState:UIControlStateNormal];
    [bigManHeaderView addSubview:moreButton2];
    [moreButton2 addTarget:self action:@selector(moreButton2Action) forControlEvents:UIControlEventTouchUpInside];
    moreButton2.centerY = bigManHeaderView.height * 0.5;
    moreButton2.right = bigManHeaderView.width - 20;
#pragma mark -- end
    
    
    
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, self.bigManTableView.bottom);
    
}

#pragma makr -- 判断是否登录
//是否需要登录
-(BOOL)isLogin{
    return NO;
}

//进入登录
-(void)goLogin
{
    LoginViewController* loginVC = [LoginViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --顶部按钮点击响应
-(void)topButton0Action:(id)sender
{
    [self showAlert:nil message:@"自选股正在开发"];
}

-(void)topButton1Action:(id)sender
{
    [self showAlert:nil message:@"投资组合正在开发"];
}

-(void)topButton2Action:(id)sender
{
    [self showAlert:nil message:@"猜大盘正在开发"];
}

-(void)topButton3Action:(id)sender
{
    [self showAlert:nil message:nil];
}

-(void)topButton4Action:(id)sender
{
    StockGameViewController* stockGameVC = [StockGameViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:stockGameVC animated:YES];
}

-(void)topButton5Action:(id)sender
{
    [self showAlert:nil message:nil];
}

-(void)topButton6Action:(id)sender
{
    //[self showAlert:nil message:nil];
    ViewController* game = [[ViewController alloc]init];
    [self presentViewController:game animated:YES completion:nil];
}

#pragma mark -- 广告图片点击响应
-(void)TapAction:(id)sender
{
    UITapGestureRecognizer* tempTap = (UITapGestureRecognizer*)sender;
    if(tempTap == _tap0){
        NewsContentViewController* newsVC = [NewsContentViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsVC animated:YES];
    }else if (tempTap == _tap1){
        NewsContentViewController* newsVC = [NewsContentViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsVC animated:YES];
    }else{
        NewsContentViewController* newsVC = [NewsContentViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsVC animated:YES];
    }
}

#pragma mark -- 精华帖 点击更多
-(void)MorePostButtonAction
{
    PostListViewController* postListVC = [PostListViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:postListVC animated:YES];
}

#pragma mark -- 热门股票 点击更多
-(void)moreStockButtonAction
{
    HotStockListViewController* hotListVC = [HotStockListViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotListVC animated:YES];
}

#pragma mark -- 牛人 点击更多
-(void)moreButton2Action
{
    BigManListViewController* bigManListVC = [BigManListViewController new];
    bigManListVC.bigManArray = _bigManArray;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bigManListVC animated:YES];
}

#pragma mark -- ==================tableview delegate====================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.postTableView){
        return 5;
    }else{
        return 3;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.postTableView){ //精华帖
        static NSString * identifier0 = @"xibCell0";
        UINib *nib=[UINib nibWithNibName:@"NicePostTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier0];
        NicePostTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if(!cell0){
             cell0 = [[NicePostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
        }
        if(_nicePostTop3Array.count > 0){
             //头像图片处理
            NSString* endStr = [[_nicePostTop3Array objectAtIndex:indexPath.row]valueForKey:@"save_name"];
            NSString* middleStr = [[_nicePostTop3Array objectAtIndex:indexPath.row]valueForKey:@"save_path"];
            NSString* imageUrlStr = [NSString stringWithFormat:@"%@%@%@",Url_GetImage,middleStr,endStr];
            NSURL* imageUrl = [NSURL URLWithString:imageUrlStr];
            [cell0.headImageView sd_setImageWithURL:imageUrl];
            //微博用户名
            cell0.authorLabel.text = [[_nicePostTop3Array objectAtIndex:indexPath.row]valueForKey:@"uname"];
            //微博标题
            cell0.titleLabel.text = [[_nicePostTop3Array objectAtIndex:indexPath.row]valueForKey:@"weibo_title"];
            //评论数
            cell0.commentCountLabel.text =[[_nicePostTop3Array objectAtIndex:indexPath.row]valueForKey:@"comment_count"];
        }
        
        return cell0;
    }else if(tableView == self.hotStockTableView){ //热门股
        static NSString * identifier1 = @"xibCell1";
        UINib *nib=[UINib nibWithNibName:@"HotStockTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier1];
        HotStockTableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if(!cell1){
            cell1 = [[HotStockTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        return cell1;

    }else if(tableView == self.bigManTableView){//牛人//BigManTableViewCell
        static NSString * identifier2 = @"xibCell2";
        UINib *nib=[UINib nibWithNibName:@"BigManTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier2];
        BigManTableViewCell* cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if(!cell2){
            cell2 = [[BigManTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        
        
        if(_bigManTop3Array.count>0){
            
            //处理头像
            NSString* middleStr = [[_bigManTop3Array objectAtIndex:indexPath.row]valueForKey:@"save_path"]; //中间参数
            NSString* imageUrlStr = [NSString stringWithFormat:@"%@%@%@",Url_GetImage1,middleStr,ImageLL];
            NSURL* imageUrl = [NSURL URLWithString:imageUrlStr];
           // [cell2.headImageView sd_setImageWithURL:imageUrl];
            [cell2.headImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"man"]];
            
            
            //处理用户名
            cell2.nameLabel.text = [[_bigManTop3Array objectAtIndex:indexPath.row]valueForKey:@"uname"];
            
            //处理介绍
            NSString* introStr = [[_bigManTop3Array objectAtIndex:indexPath.row]valueForKey:@"intro"];
            if([introStr isEqual:[NSNull null]] || introStr.length ==0 ){
                cell2.describeLabel.text = @"暂无介绍";
            }else{
                cell2.describeLabel.text = introStr;
            }

        }
        
        return cell2;
    }else{ //其它条件下的判断
        UITableViewCell* cell = [UITableViewCell new];
        return cell;
    }
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.postTableView )  //精华帖子 
      return 80;
    else
        return 100;
}


//点击cell 跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([UserInfo sharedInfo].userId==nil ){
        [self showAlert:nil message:@"请先登录"];
    }
    if(tableView == self.postTableView){  //精华帖 跳转列表
        OnePostDetailViewController* OnePostVC = [OnePostDetailViewController new];
        NSString* feedId = [[_nicePostTop3Array objectAtIndex:indexPath.row]valueForKey:@"feed_id"];
        OnePostVC.feed_id = feedId;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:OnePostVC animated:YES];
    }if(tableView == self.hotStockTableView){ //热门股跳转到列表
        OneStockViewController* oneStockVC = [OneStockViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:oneStockVC animated:YES];
    }if(tableView==self.bigManTableView){ //点击牛人列表
        UserCenterViewController* centerVC = [UserCenterViewController new];
        NSDictionary* oneMan = [_bigManArray objectAtIndex:indexPath.row];
        if([oneMan[@"uid"] isEqual:[UserInfo sharedInfo].userId]){
            centerVC.self.isOtherPeople = NO;
        }else{
            centerVC.self.isOtherPeople = YES;
        }
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:centerVC animated:YES];
        
    }
}

//提示框
-(void)showAlert:(NSString*)title
         message:(NSString*)message
{
    if(title==nil){
        title = @"提示";
    }
    if(message==nil){
        message = @"该功能正在开发...";
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
#pragma mark -- ====================初始化全局变量======================
-(void)initGlobalMenbers
{
    _nicePostArray = [[NSArray alloc]init];
    _nicePostTop3Array = [[NSMutableArray alloc]init];
    
    _bigManArray =[[ NSArray alloc]init];
    _bigManTop3Array = [[NSMutableArray alloc]init];
}

#pragma mark -- =====================网络请求======================
#pragma mark -- 请求 微博精华帖列表
-(void)requestGoodPostData//获取精华帖列表
{
    NSString* url = [CommonMethod UrlAddAction:Url_GoodPost];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:@"2" forKey:@"position"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        _nicePostArray = jsonDic[@"data"];
        
        if(_nicePostArray.count > 0){ //如果返回了数据
            for(int i = 0; i < 5; i++){
                [_nicePostTop3Array addObject:[_nicePostArray objectAtIndex:i]];
            }
        }
        //NSLog(@"精华帖返回数据：%@",_nicePostArray );
        [self.postTableView reloadData];
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"精华帖请求错误%@",error);
    }];
}

#pragma mark -- 请求 牛人列表
-(void)requestBigManData
{
    NSString* url = [CommonMethod UrlAddAction:Url_BigMan];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:@"1" forKey:@"p"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if(jsonDic.count > 0){
            _bigManArray = [jsonDic valueForKey:@"data"];
        }
        if(_bigManArray.count > 0){
            for(int i = 0; i < 3; i++){
                [_bigManTop3Array addObject:[_bigManArray objectAtIndex:i]];
            }
        }
        
        [self.bigManTableView reloadData];
        //NSLog(@"牛人列表返回数据：%@",jsonDic);
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"牛人列表请求错误%@",error);
        [self showError];
    }];

    
}

//-(void)requestData  //登录请求
//{
  //  NSString* url = [CommonMethod createURLWithRamdonNumber:nil];
    
    
//    NSMutableDictionary* dic = [NSMutableDictionary new];
//    [dic setObject:@"1061550505@qq.com" forKey:@"login_email"];
//    [dic setObject:@"12345678" forKey:@"login_password"];
//    [dic setObject:@"1" forKey:@"login_remember"];
//  
//    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
//    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
//    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSDictionary* dic = [CommonMethod serializdDictionaryWithResponseObject:responseObject];
//        NSLog(@"%@",dic);
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        
//    }];
//}

#pragma mark --辅助方法
//-(NSDictionary*)serializdDictionaryWithResponseObject:(id)responseObject
//{
//    NSString *jsonString=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//    if(!err){
//        return jsonDic;
//    }else{
//        return nil;
//    }
//}

-(int)getRandomNumber:(int)from to:(int)to    //[ )

{
    return (int)(from + (arc4random() % (to - from + 1)));
}



@end
