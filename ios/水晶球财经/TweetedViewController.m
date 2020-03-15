//
//  TweetedViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/12.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "TweetedViewController.h"
#import "UIViewExt.h"
#import "SendOutCommentCell.h"
#import "CommonMethod.h"
#import "AFNetworking.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
@interface TweetedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //对整个tableview而言
    NSMutableArray* _datasourse;
    NSArray* _partDataSourse;
    
    //对一个cell中而言 分成了两部分
    NSMutableArray* _myContentArray;   //数组里面只有 我发出的内容字符串
    NSMutableArray* _otherContentArray; //数组里面只有 别人的内容字符串
}

@end

@implementation TweetedViewController

-(void)viewDidAppear:(BOOL)animated
{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT - 64;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"发出的评论";
    
    [self initGloableData];
     [self show];
    [self requestMyCommentListData];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)initGloableData
{
    
    _datasourse = [NSMutableArray new];
    _partDataSourse = [NSArray new];
    
    
    _myContentArray = [NSMutableArray new];
    _otherContentArray =[NSMutableArray new];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- ==========tableview delegate==========
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_partDataSourse count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    UINib *nib=[UINib nibWithNibName:@"SendOutCommentCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifer];
    
    SendOutCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell){
        cell = [[SendOutCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.middleLine.backgroundColor = APPBackColor;
    
    //数据源 有数据
    if(_partDataSourse.count > 0){
        //处理头像0
        NSString* image0Str = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"user_info"]valueForKey:@"avatar_big"];
        [cell.imageView0 sd_setImageWithURL:[NSURL URLWithString:image0Str] placeholderImage: PLACEHOLDERIMAGE];
        //处理名字0
        NSString* name0 = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"user_info"]valueForKey:@"uname"];
        cell.nameLabel0.text = name0;
        //处理时间0
        NSString*time0 = [[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"ctime"];
        cell.timeLabel0.text = [CommonMethod getTimeStrWithTimeStamp:time0];
        //处理内容0
        NSString* contentStr0 =[_myContentArray objectAtIndex:indexPath.row];
        NSLog(@"这里是第一次打印原始字符串:%@",contentStr0);
        contentStr0 = [CommonMethod dealImageInHTMLContentString:contentStr0];
        NSAttributedString *attributedString0 = [[NSAttributedString alloc] initWithData:[contentStr0 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
      //  NSLog(@"这里是第二次打印，被处理后的富文本字符串%@",attributedString0);
        cell.textView0.attributedText = attributedString0;
        cell.textView0.backgroundColor = RGB(240, 240, 242);
        
        
        
        //处理头像1
        NSString* image1Str = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"sourceInfo"]valueForKey:@"avatar_big"];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:image1Str] placeholderImage:PLACEHOLDERIMAGE];
        
        //处理名字1
        NSString* name1 = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"sourceInfo"]valueForKey:@"uname"];
        cell.nameLabel1.text = name1;
        
        //处理时间1
        NSString* time1 = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"sourceInfo"]valueForKey:@"ctime"];
        cell.timeLabel1.text = [CommonMethod getTimeStrWithTimeStamp:time1];
        //处理内容1
        NSString* contentStr1 =[_otherContentArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithData:[contentStr1 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        cell.textView1.attributedText = attributedString1;
        cell.textView1.backgroundColor = RGB(240, 240, 242);
    }//如果数据源个数大于0 条件结束
    
    
    
    CGFloat height0 = [self heightForTextView:0 IndexPath:indexPath];
    CGFloat height1 = [self heightForTextView:1 IndexPath:indexPath];
    
    //修改textView0高度
    if(height0>30){
        cell.textView0.height = height0;
    }else{
        cell.textView0.height = 30;
    }
    
    //修改中间线条高度
    cell.middleLine.top = 104 + (height0 - 30); //cell.middleLine.top = 104
    
    //修改第二张头像
    cell.imageView1.top = 114 + (height0 - 30);//cell.imageView1.top
    //修改第二个title
    cell.nameLabel1.top = 118 + (height0 - 30);//cell.nameLabel1.top
    
    //修改第textView1高度
    cell.textView1.top = 155 + (height0 - 30);//cell.textView1.top
    
    if(height1>45){
        cell.textView1.height = height1;
    }else{
        cell.textView1.height = 45;
    }
    
    //修改第二个时间
    cell.timeLabel1.top = 212 + (height0 - 30) + (height1 - 45);//cell.timeLabel1.top
    
    //修改底部线条
    cell.bottomLine.top = 245 + (height0 - 30) + (height1 - 45);//cell.bottomLine.top
    
    cell.height = 250 + (height0 - 30) +  (height1 - 45);//cell.height
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height0 = [self heightForTextView:0 IndexPath:indexPath];
    CGFloat height1 = [self heightForTextView:1 IndexPath:indexPath];
    CGFloat result = 250 + (height0 - 30) +  (height1 - 45);
    return result;
}


-(CGFloat)heightForTextView:(int)MyOrOther//传入
                  IndexPath:(NSIndexPath*)indexPath //传入索引
{
    if(MyOrOther==0){//我的
        NSString* contentStr =[_myContentArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UITextView* tempLabel = [UITextView new];
        tempLabel.width = SCREENWIDTH - 16;
        tempLabel.height = 0;
        tempLabel.attributedText = attributedString;
        return tempLabel.contentSize.height;
        
    }else{//其他人的
        NSString* contentStr =[_otherContentArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UITextView* tempLabel = [UITextView new];
        tempLabel.width = SCREENWIDTH - 16;
        tempLabel.height = 0;
        tempLabel.attributedText = attributedString;
        return tempLabel.contentSize.height;
        
    }
    
}

#pragma mark -- ================网络请求==============
//发出的评论
-(void)requestMyCommentListData
{
    NSString* url = [CommonMethod UrlAddAction:Url_Message_MyCommentList];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:@"send" forKey:@"type"];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    
   
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
       
        NSLog(@"我发出的评论列表返回数据是:%@",jsonDic);
        if([jsonDic[@"status"] isEqual:@1]){
            _partDataSourse = jsonDic[@"data"][@"data"];//只有20条数据
          
            //装载全部我发出的信息  装载装载全部回复信息
            if([_myContentArray count] > 0 ){
                [_myContentArray removeAllObjects];
            }
            if([_otherContentArray count] > 0){
                [_otherContentArray removeAllObjects];
            }
            
            if([_partDataSourse count] > 0){
                for(int i = 0 ; i < [_partDataSourse count]; i++){
                    NSDictionary* oneCellInfo = [_partDataSourse objectAtIndex:i]; //一条cell信息
                    NSString* oneContentStr = [oneCellInfo valueForKey:@"content"];
                    NSLog(@"%@",oneContentStr);  //这里是刚刚获取到的字符串
                    [_myContentArray addObject:oneContentStr];
                    
                    NSString* oneSourceContentStr = [[oneCellInfo valueForKey:@"sourceInfo"]valueForKey:@"feed_content"];
                    oneSourceContentStr = [NSString stringWithFormat:@"%@",oneSourceContentStr];
                    [_otherContentArray addObject:oneSourceContentStr];
                }
                [self.tableView reloadData];
            }
        }//if([jsonDic[@"status"] isEqual:@1]) end
          [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"发出的评论请求错误%@",error);
    }];

}

@end
