//
//  OnePostDetailViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.


#import "OnePostDetailViewController.h"
#import "UIViewExt.h"
#import "UILabel+StringFrame.h"
#import "UILabel+ChangeBoundByString.h"

#import "AllReplyTableViewCell.h" //全部回复

#import "UserInfo.h"
#import "AFNetworking.h"
#import "CommonMethod.h"
#import "UIImageView+WebCache.h"

#import "UILabel+ChangeBoundByString.h"  //判断webView高度 和 cell 高度咯
#import "MakeCommentViewController.h"
#import "TransmitViewController.h"
#import "UIImage+scaleSize.h"


@interface OnePostDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ///////////////////////////////////////////////// UI
    UIView* _header;          //整个 tableview的 header
    
    //////////////////////////////////////////////////数据
    NSDictionary* _authorInfoDic;     //微博作者信息
    NSDictionary* _postInfoDic;      //这一条微博信息
    NSArray* _commentListArray;   //回复信息
}

@end

@implementation OnePostDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
//    [self show];
//    [self requestPostData]; //请求微博数据
//    [self requestCommentData];//请求回复数据
    //这个group 中的任务： 优先级1.自定义队列任务先执行，main队列后执行，  优先级2.从上往下降低。
//    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group=dispatch_group_create();
//
//    dispatch_group_async(group, queue, ^{
//        [self requestPostData]; //获取精华帖内容
//        [self requestCommentData];//获取评论数据
//    });
//    dispatch_group_async(group, queue, ^{
//        [self.tableView reloadData];
//    });
//    dispatch_group_async(group, dispatch_get_main_queue(), ^{
//        self.view.userInteractionEnabled = NO;
//        [self show];
//    });
//    dispatch_group_async(group, dispatch_get_main_queue(), ^{
//        self.view.userInteractionEnabled = YES;
//    });

}

-(void)dealWorksWithMyQueue //在viewDidLoad中执行这个方法，意味着跳转到二级页面以后 不会重复执行下面方法
{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        [self requestPostData]; //获取精华帖内容
        [self requestCommentData];//获取评论数据
    });
    dispatch_group_async(group, queue, ^{
        [self.tableView reloadData];
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        self.view.userInteractionEnabled = NO;
        [self show];
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        self.view.userInteractionEnabled = YES;
    });

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"博客详情";
    self.tableView.backgroundColor = RGB(240, 240, 242);
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.width = SCREENWIDTH;
    self.tableView.height =SCREENHEIGHT - 66 - 60; //因为navigation bar  所以 减少66 底部view60
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //因为底部的评论 赞的View为100 所以 再减少34

    
     [self initGloableData];
    
    [self buildUI:nil authorName:nil PostContent:nil CreateTime:nil ForwardCount:nil GoodCount:nil commentCount:nil];
  
    
    //最后一步执行
    [self dealWorksWithMyQueue];
}

-(void)buildUI:(NSString*) HeadImageUrl  //头图片 url
    authorName:(NSString*) authorName    //作者头像
   PostContent:(NSString*) PostContent   //微博内容
    CreateTime:(NSString*) CreateTime    //创建时间
  ForwardCount:(NSString*) ForwardCount   //转发数
     GoodCount:(NSString*) GoodCount      //点赞数
  commentCount:(NSString*) commentCount   //评论数
{
    /////////////////第一步创建header
    _header = [self createTableHeader:HeadImageUrl authorName:authorName PostContent:PostContent CreateTime:CreateTime ForwardCount:ForwardCount GoodCount:GoodCount commentCount:commentCount];
    [self.view addSubview:_header];
    self.tableView.tableHeaderView = _header;
    
    /////////////////第二步创建bottomView
    //创建赞和评论用的 VIew
    UIView* bottomView = [UIView new];
    bottomView.backgroundColor = RGB(248, 248, 248);
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bottomView.width = SCREENWIDTH;
    bottomView.height = 60;
    [self.view addSubview:bottomView];
    bottomView.bottom = SCREENHEIGHT - 64;
    bottomView.left = 0;
    for(int i = 0 ; i < 5; i++){
        UILabel* constLabel = [UILabel new];
        [bottomView addSubview:constLabel];
        constLabel.font = [UIFont systemFontOfSize:12];
        constLabel.textAlignment = NSTextAlignmentCenter;
        constLabel.textColor = [UIColor blackColor];
        constLabel.width = 40;
        constLabel.height = 10;
        CGFloat space = (SCREENWIDTH - 200) * 0.166;
        constLabel.left = (i+1) * space + i * 40;
        constLabel.bottom = 55; //下面留5 距离
        if(i==0){
            constLabel.text = @"赏";
        }else if (i==1){
            constLabel.text = @"收藏";
        }else if(i==2){
            constLabel.text = @"赞";
        }else if(i==3){
            constLabel.text = @"转发";
        }else if(i==4){
            constLabel.text = @"评论";
        }
    }
    
    //最下面5个按钮
    UIButton* sangButton = [UIButton buttonWithType:UIButtonTypeCustom];//赏
    UIButton* shoucangButton = [UIButton buttonWithType:UIButtonTypeCustom]; //收藏
    UIButton* zanButton = [UIButton buttonWithType:UIButtonTypeCustom];//赞
    UIButton* zhuanButton = [UIButton buttonWithType:UIButtonTypeCustom];//转
    UIButton* pinglunButton = [UIButton buttonWithType:UIButtonTypeCustom];//评论
    
    [sangButton setBackgroundImage:[UIImage imageNamed:@"赏0"] forState:UIControlStateNormal];
    [shoucangButton setBackgroundImage:[UIImage imageNamed:@"收藏0"] forState:UIControlStateNormal];
    [zanButton setBackgroundImage:[UIImage imageNamed:@"赞新"] forState:UIControlStateNormal];
    [zhuanButton setBackgroundImage:[UIImage imageNamed:@"转发新"] forState:UIControlStateNormal];
    [pinglunButton setBackgroundImage:[UIImage imageNamed:@"评论新"] forState:UIControlStateNormal];
    
    [bottomView addSubview:sangButton];
    [bottomView addSubview:shoucangButton];
    [bottomView addSubview:zanButton];
    [bottomView addSubview:zhuanButton];
    [bottomView addSubview:pinglunButton];
    
    //增加响应
    //点赞
    [zanButton addTarget:self action:@selector(DigAction:) forControlEvents:UIControlEventTouchUpInside];
    //收藏
    [shoucangButton addTarget:self action:@selector(CollectAction:) forControlEvents:UIControlEventTouchUpInside];
    //评论
    [pinglunButton addTarget:self action:@selector(pinlunAction) forControlEvents:UIControlEventTouchUpInside];
    //转发
    [zhuanButton addTarget:self action:@selector(zhuanAction) forControlEvents:UIControlEventTouchUpInside];
    
  
    //宽高
    sangButton.width =sangButton.height = shoucangButton.width = shoucangButton.height = zanButton.width = zanButton.height = zhuanButton.height = zhuanButton.width = pinglunButton.width = pinglunButton.height = 40;
    
    //top
    sangButton.top = shoucangButton.top = zanButton.top =zhuanButton.top =pinglunButton.top = 0;
   
    //left
    sangButton.left = (SCREENWIDTH - 200) * 0.16666;
    shoucangButton.left = sangButton.right + sangButton.left;
    zanButton.left = shoucangButton.right + sangButton.left;
    zhuanButton.left = zanButton.right + sangButton.left;
    pinglunButton.left = zhuanButton.right + sangButton.left;

}
//创建Header UI
-(UIView*)createTableHeader :(NSString*) HeadImageUrl  //头图片 url
                  authorName:(NSString*) authorName    //作者名字
                 PostContent:(NSString*) PostContent   //微博内容
                  CreateTime:(NSString*) CreateTime    //创建时间
                ForwardCount:(NSString*) ForwardCount   //转发数
                   GoodCount:(NSString*) GoodCount      //点赞数
                commentCount:(NSString*) commentCount   //评论数
{
    UIView* header = [UIView new];
    header.backgroundColor = [UIColor whiteColor];
    header.width = SCREENWIDTH;
    header.height = 300;
    
    // 图片
    UIImageView* headImageView = [[UIImageView alloc]init];
    headImageView.backgroundColor = [UIColor orangeColor];
    
    if(_authorInfoDic.count==0){
        headImageView.image = [UIImage imageNamed:@"man"];
    }else{
        [headImageView sd_setImageWithURL:[NSURL URLWithString:HeadImageUrl] placeholderImage:[UIImage imageNamed:@"man"]];
    }
    
    [header addSubview:headImageView];
    headImageView.width = headImageView.height = 50;
    headImageView.top =20;
    headImageView.left = 10;
    
    //隔离竖线
    UIView* lineView= [UIView new];
    [header addSubview:lineView];
    lineView.width = 2;
    lineView.height = 300;  //注意 这里高度还没有设置
    lineView.left = 70;
    lineView.top = 0;
    lineView.backgroundColor = RGB(240, 240, 242);
    
    //作者姓名
    UILabel* nameLabel= [UILabel new];
    [header addSubview:nameLabel];
    if(_authorInfoDic.count==0){
     nameLabel.text = @"暂无信息";
    }else{
        nameLabel.text = authorName;
    }
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.width = 120;
    nameLabel.height = 40;
    nameLabel.left = lineView.left;
    nameLabel.top = 10;
    
    //title 名称
     UILabel* titleLabel = [UILabel new];
    [header addSubview:titleLabel];
    titleLabel.text = @"博主";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.width = 40;
    titleLabel.height = 40;
    titleLabel.right = SCREENWIDTH - 20;
    titleLabel.top = nameLabel.top;
    
    
    //微博内容
    UITextView* textView = [UITextView new];
    textView.scrollEnabled = YES;
    textView.editable = NO;
    [header addSubview:textView];
    textView.height = 0;
    textView.width = titleLabel.right - nameLabel.left;
    textView.left = nameLabel.left;
    textView.top = nameLabel.bottom + 15;
    textView.backgroundColor = RGB(240, 240, 242);
    
    NSString* contentStr = [NSString new];
    if(_authorInfoDic.count==0){
        contentStr = @" ";
    }else{
        //contentStr处理下图片问题
       // NSLog(@"微博内容是：%@",PostContent);
#pragma mark ------测试代码开始  解决图片过大的问题
        NSMutableArray* newStrArray=  [NSMutableArray new];
        
        // NSString* str = @"12345<img第一张图/>123456<img第二章图/>123456";
        NSArray *array = [PostContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];  //array是  <> 的全部数据
        //  NSLog(@"%@",array);
        for(int i = 0; i < [array count]; i++){
            NSString* str0 = [array objectAtIndex:i];
            if([str0 rangeOfString:@"img "].location != NSNotFound)
            {
                //NSLog(@"%@",str0);   //图片的字符串 只是没有<>
                NSArray* array = [str0 componentsSeparatedByString:@"src="];
                NSString* imageUrlStr = [[array lastObject]stringByReplacingOccurrencesOfString:@" /" withString:@""];
               // NSLog(@"======\n%@\n",imageUrlStr);   // 最后那个图片字符串
                [newStrArray addObject:imageUrlStr];
            }
        }
        
        for(int i = 0; i < [newStrArray count]; i++){
            NSString* imageUrlStr = [newStrArray objectAtIndex:i];
            PostContent = [PostContent stringByReplacingOccurrencesOfString:imageUrlStr withString:[NSString stringWithFormat:@"%@width='%f'",imageUrlStr,textView.width-10]];
        }
        //NSLog(@"%@",PostContent);
        
#pragma makr ------测试代码结束
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[PostContent  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}documentAttributes:nil error:nil];
        //显示
        textView.attributedText = attributedString;
        

    }
    
   // textView.text = contentStr;
    
    textView.frame = CGRectMake(textView.left, textView.top, textView.width, textView.contentSize.height);
//    textView.contentSize = CGSizeMake(textView.contentSize.width, textView.height);

    
    //微博内容
//    UILabel* contentLabel = [[UILabel alloc]init];
//    contentLabel.height = 0; //高度先设置为0
//    contentLabel.width = titleLabel.right - nameLabel.left;
//    contentLabel.textColor = [UIColor blackColor];
    
//     NSString* contentStr = [NSString new];
//    if(_authorInfoDic.count==0){
//      contentStr = @"                                                                         ";
//    }else{
//        contentStr = PostContent;
//    }
//     contentLabel = [UILabel linesText:contentStr font:contentLabel.font wid:contentLabel.width lines:0 color:[UIColor blackColor]];
    
//    [header addSubview:contentLabel];
//    contentLabel.backgroundColor = [UIColor orangeColor];
//    contentLabel.left = nameLabel.left;
//    contentLabel.top = nameLabel.bottom + 20;
    
    
    //发布时间
    UILabel* timeLabel = [UILabel new];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.textColor = [UIColor lightGrayColor];
    if(_authorInfoDic.count==0){
         timeLabel.text = @"暂无时间信息";
    }else{
        timeLabel.text = [CommonMethod getTimeStrWithTimeStamp:CreateTime];
    }
    
    timeLabel.width = 150;
    timeLabel.height = 40;
    timeLabel.left = textView.left;
    timeLabel.top = textView.bottom + 5;
    [header addSubview:timeLabel];
    
    
    //评论  转发  点赞
    UILabel* commentLabel = [UILabel new];
    [header addSubview:commentLabel];
    commentLabel.backgroundColor = RGB(240, 240, 242);
    commentLabel.width = 40;
    commentLabel.height = 30;
    commentLabel.left = 5;
    commentLabel.top = timeLabel.bottom+5;
    commentLabel.textColor = [UIColor redColor];
    commentLabel.font = [UIFont systemFontOfSize:12];
    commentLabel.textAlignment = NSTextAlignmentRight;
    commentLabel.text = @"评论";
    
    //评论数
    UILabel* commentCountLabel = [UILabel new];
    [header addSubview:commentCountLabel];
    commentCountLabel.backgroundColor = RGB(240, 240, 242);
    commentCountLabel.width = 20;
    commentCountLabel.height = 30;
    commentCountLabel.left = commentLabel.right;
    commentCountLabel.top = commentLabel.top;
    commentCountLabel.textColor = [UIColor redColor];
    commentCountLabel.textAlignment = NSTextAlignmentLeft;
    commentCountLabel.font = [UIFont systemFontOfSize:12];

    commentCountLabel.text = commentCount;
    
    //转发
    UILabel* relayLabel = [UILabel new];
    [header addSubview:relayLabel];
    relayLabel.backgroundColor = RGB(240, 240, 242);
    relayLabel.width = 40;
    relayLabel.height = 30;
    relayLabel.left = commentCountLabel.right + 3;
    relayLabel.top = commentCountLabel.top;
    relayLabel.textColor = [UIColor redColor];
    relayLabel.font = [UIFont systemFontOfSize:12];
    relayLabel.textAlignment = NSTextAlignmentRight;
    relayLabel.text = @"转发";
    
    //转发数
    UILabel* relayCountLabel = [UILabel new];
    [header addSubview:relayCountLabel];
    relayCountLabel.backgroundColor = RGB(240, 240, 242);
    relayCountLabel.width = 40;
    relayCountLabel.height = 30;
    relayCountLabel.left = relayLabel.right ;
    relayCountLabel.top = relayLabel.top;
    relayCountLabel.textColor = [UIColor redColor];
    relayCountLabel.font = [UIFont systemFontOfSize:12];
    relayCountLabel.textAlignment = NSTextAlignmentLeft;

    relayCountLabel.text = ForwardCount;
    
    //赞数量
    UILabel* goodCountLabel = [UILabel new];
    [header addSubview:goodCountLabel];
    goodCountLabel.backgroundColor = RGB(240, 240, 242);
    goodCountLabel.width = 20;
    goodCountLabel.height = 30;
    goodCountLabel.right = textView.right ;
    goodCountLabel.top = relayLabel.top;
    goodCountLabel.textColor = [UIColor redColor];
    goodCountLabel.font = [UIFont systemFontOfSize:12];
    goodCountLabel.textAlignment = NSTextAlignmentLeft;

    goodCountLabel.text = GoodCount;
    
    //赞
    UILabel* goodLabel = [UILabel new];
    [header addSubview:goodLabel];
    goodLabel.backgroundColor = RGB(240, 240, 242);
    goodLabel.width = 40;
    goodLabel.height = 30;
    goodLabel.right = goodCountLabel.left ;
    goodLabel.top = relayLabel.top;
    goodLabel.textColor = [UIColor redColor];
    goodLabel.font = [UIFont systemFontOfSize:12];
    goodLabel.textAlignment = NSTextAlignmentRight;
    goodLabel.text = @"赞";
    
    //底部线条
    UIView* bottomLine = [UIView new];
    bottomLine.width = SCREENWIDTH;
    bottomLine.height = 1;
    [header addSubview:bottomLine];
    bottomLine.left = 0;
    bottomLine.top = goodLabel.bottom+5;
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    
    //重新变动header的高度
    header.backgroundColor = RGB(240, 240, 244);
    header.height = bottomLine.bottom;
    
    return header;
}


-(void)initGloableData
{
    _header = [UIView new];
    _authorInfoDic = [NSDictionary new];
    _postInfoDic  = [NSDictionary new];
    _commentListArray = [NSArray new];
}


#pragma mark -- ===================请求数据==================
#pragma mark --  微博详情
-(void)requestPostData
{
    NSString* url = [CommonMethod UrlAddAction:Url_OnePost];
    
    NSMutableDictionary* dic = [NSMutableDictionary new];
    [dic setObject:self.feed_id forKey:@"feed_id"];
    if([UserInfo sharedInfo].userId){ //非空
         [dic setObject:self.feed_id forKey:@"mid"];
    }else{
        [self showAlert:@"警告" :@"获取微博详情 必须先登录"];
        return;
    }
   
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary* jsonDic = [CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if(jsonDic){ //如果请求成功
           // NSLog(@"博客详情返回内容:%@",jsonDic);
            if([[jsonDic valueForKey:@"status" ] isEqual:@1]){ //如果数据正确
                
                _authorInfoDic =  jsonDic[@"data"][@"userinfo"];
                _postInfoDic = jsonDic[@"data"][@"feedinfo"];
                
                
                [self buildUI:_authorInfoDic[@"avatar_big"] authorName:_authorInfoDic[@"uname"] PostContent:_postInfoDic[@"content"] CreateTime:_postInfoDic[@"publish_time"] ForwardCount:_postInfoDic[@"repost_count"] GoodCount:_postInfoDic[@"digg_count"] commentCount:_postInfoDic[@"comment_all_count"]];
            
            }

        }
   
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];
    }];
    
}

#pragma mark --  回复详情
-(void)requestCommentData
{
    NSString* url = [CommonMethod UrlAddAction:Url_OnePost_Comment];
    
    NSMutableDictionary* dic = [NSMutableDictionary new];
    [dic setObject:self.feed_id forKey:@"feed_id"];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary* jsonDic = [CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if(jsonDic){ //如果请求成功
            if([[jsonDic valueForKey:@"status" ] isEqual:@1]){ //如果数据正确
            NSLog(@"微博评论成功返回数据：%@",jsonDic);
                id result = jsonDic[@"data"][@"data"];
                if(result==nil || [result isEqual:@""]){
                   //不做赋值操作
                }else{
                    _commentListArray = result;
                }
                [self.tableView reloadData];
            }
            
        }
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self dismiss];
    }];

}


//请求数据后 改变headerView
-(void)dealWithHeaderView
{
//    //处理头像
//    NSString* headImage=  _authorInfoDic[@"avatar_big"];
//    [_headImageView sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:[UIImage imageNamed:@"男"]];
    
    //处理姓名
   // _nameLabel.text = _authorInfoDic[@"uname"];
    
    //处理微博内容
    //NSString* contentString = _postInfoDic[@"content"];
   // [_contentLabel removeFromSuperview];
//     _contentLabel = [UILabel linesText:contentString font:_contentLabel.font wid:_contentLabel.width lines:0 color:[UIColor blackColor]];
//    [_header addSubview:_contentLabel];
//    _contentLabel.backgroundColor = [UIColor orangeColor];
//    _contentLabel.left = _nameLabel.left;
//    _contentLabel.top = _nameLabel.bottom + 20;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([UserInfo sharedInfo].userId==nil){ //如果没有登录
        return 0;
    }else{
        return [_commentListArray count];
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  //  NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
//    cell = (RouteImgViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell identifer
//    if (cell == nil) {
//        cell = [[RouteImgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 //   }
    
    

NSString *identifer = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    UINib *nib=[UINib nibWithNibName:@"AllReplyTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifer];
    AllReplyTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell){
        cell = [[AllReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if(_commentListArray.count>0){
      NSDictionary*oneCommentInfo =  [_commentListArray objectAtIndex:indexPath.row];
       //处理头像
        NSString* headImageStr = oneCommentInfo[@"user_info"][@"avatar_big"];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:headImageStr] placeholderImage:DefaultUserImage];
        //处理名字
        NSString* guestName = oneCommentInfo[@"user_info"][@"uname"];
        cell.nameLabel.text = guestName;
                
        //处理楼数
        NSString* flour = oneCommentInfo[@"storey"];
        cell.floorLabel.text = [NSString stringWithFormat:@"%@楼",flour];
        
        //处理评论内容
        NSString* content = oneCommentInfo[@"content"];
        NSString* html_str = content;
        NSString* oldPartStr = @"__THEME__";
        NSString* newPartStr = @"http://www.sjqcj.com/addons/theme/stv1/_static";
        NSString* newHtmlStr = [html_str stringByReplacingOccurrencesOfString:oldPartStr withString:newPartStr];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[newHtmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        cell.textView.height = 0;
        cell.textView.width = SCREENWIDTH - 66 - 20;
        cell.textView.attributedText = attributedString;
        cell.textView.editable = NO;
        
        //处理创建时间
        NSString* time0 =  oneCommentInfo[@"ctime"]; //json中获取时间戳
        NSTimeInterval time=[time0 doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        cell.createTimeLabel.text = currentDateStr; //json中的时间戳 最终化成了时间
        
        
        ////////////////////////////////////重新设置cell的高度
        CGFloat contentHeight = cell.textView.contentSize.height;//加载了富文本以后的textView 内容高度发生改变
        if(contentHeight > 45){//重新设置cell高度  和 textView高度
            cell.textView.height = cell.textView.contentSize.height;
            cell.height = 120+(contentHeight-45);
        }else{
            contentHeight = 45;
            cell.textView.height = 45;
            cell.height = 120;
        }
        
        
        
        //重新设置 点赞，发言 位置
        cell.createTimeLabel.centerY = cell.RePostButton.centerY= cell.speakButton.centerY = cell.textView.bottom + 15;//和xib同步
       
        
        
        //重新设置底部线条
//        UIView* bottomView = [UIView new];
//        [cell addSubview:bottomView];
//        bottomView.width = SCREENWIDTH;
//        bottomView.height = 1;
//        bottomView.left = 0;
//        bottomView.top = cell.bottom;
//        bottomView.backgroundColor = [UIColor lightGrayColor];
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.layer.borderWidth = 1;
        cell.backgroundColor = RGB(65.49, 39.65, 42.67);
    }
       return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_commentListArray.count>0){
        CGFloat textViewheight= [self getNewHeightForTextView:indexPath];
        if(textViewheight > 45){
            return 120 + (textViewheight - 45) ; //只是增加textView的增量
        }else{
            return 120;
        }
    }else//全局数组没有数据
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)getNewHeightForTextView:(NSIndexPath*)indexPath
{
         //准备评论内容字符串
         NSDictionary*oneCommentInfo = [NSDictionary new];
         oneCommentInfo = [_commentListArray objectAtIndex:indexPath.row];
         NSString* content = oneCommentInfo[@"content"];
         NSString* html_str = content;
         NSString* oldPartStr = @"__THEME__";
         NSString* newPartStr = @"http://www.sjqcj.com/addons/theme/stv1/_static";
         NSString* newHtmlStr = [html_str stringByReplacingOccurrencesOfString:oldPartStr withString:newPartStr];
         NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[newHtmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    //根据字符串得到textView的frame
        UITextView* tempLabel = [UITextView new];
        tempLabel.width = SCREENWIDTH - 66 - 20;
        tempLabel.height = 0;

    tempLabel.attributedText = attributedString;
    return tempLabel.contentSize.height;
    
}

#pragma mark -- 赏，收藏，赞，转发，评论 增加响应
-(void)DigAction:(id)sender//点赞
{
    UIButton* pButton = (UIButton*)sender;
    NSString* url = [CommonMethod UrlAddAction:Url_Post_Dig];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:self.feed_id forKey:@"feed_id"]; //主微博ID
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        // NSLog(@"点赞信息返回数据%@",jsonDic);
        if([jsonDic[@"status"]isEqual:@1]){ //如果操作成功
            dispatch_async(dispatch_get_main_queue(), ^{
                pButton.backgroundColor = [UIColor redColor];
            });
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"点赞操作错误%@",error);
    }];
}

-(void)pinlunAction//对微博评论
{
    MakeCommentViewController * commentVC = [MakeCommentViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
}

-(void)zhuanAction//转发
{
    TransmitViewController* zhuanVC = [TransmitViewController new];
    zhuanVC.feed_id = self.feed_id;
    [self.navigationController pushViewController:zhuanVC animated:YES];
}

-(void)CollectAction:(id)sender//收藏
{
    UIButton* pButton = (UIButton*)sender;
    NSString* url = [CommonMethod UrlAddAction:Url_Post_Collect];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:self.feed_id forKey:@"feed_id"]; //主微博ID
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        // NSLog(@"收藏操作成功返回数据%@",jsonDic);
        if([jsonDic[@"status"]isEqual:@1]){ //如果操作成功
            dispatch_async(dispatch_get_main_queue(), ^{
                pButton.backgroundColor = [UIColor redColor];
            });
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"收藏操作返回错误%@",error);
    }];

    
}

//提示框  这个方法 只能在当前类中使用
-(void)showAlert:(NSString*)title :(NSString*)message
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


#pragma mark -- 图片转化为字符串
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}


//字符串转图片
-(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
{
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:_encodedImageStr];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}
@end
