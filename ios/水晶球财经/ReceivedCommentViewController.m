//
//  ReceivedCommentViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/13.
//  Copyright © 2015年 com.sjqcj. All rights reserved.

//收到的评论界面

#import "ReceivedCommentViewController.h"
#import "UIViewExt.h"
#import "RecivedCommenCell.h"
#import "SendOutCommentCell.h"
#import "CommonMethod.h"
#import "AFNetworking.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
@interface ReceivedCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   
    //对整个tableview而言
    NSMutableArray* _datasourse;
    NSArray* _partDataSourse;
    
    //对一个cell中而言 分成了两部分
    NSMutableArray* _otherContentArray; //数组里面只有 我收到的别人的信息
    NSMutableArray* _myContentArray;   //数组里面只有  我发出的内容字符串
}

@end

@implementation ReceivedCommentViewController


-(void)viewDidAppear:(BOOL)animated
{
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收到的评论";
    // Do any additional setup after loading the view, typically from a nib.
    
     self.tableView.width = SCREENWIDTH;
     self.tableView.height = SCREENHEIGHT - 64;
     self.tableView.top = 0;
     self.tableView.left = 0;
   
     self.tableView.backgroundColor = [UIColor lightGrayColor];
     self.tableView.delegate =(id)self;
     self.tableView.dataSource = (id)self;
    
    [self initGolableData];
    [self show];
    [self requestRecivedData];
    
}

-(void)initGolableData
{
    
    _datasourse = [NSMutableArray new];
    _partDataSourse = [NSArray new];
    
    _otherContentArray = [NSMutableArray new];
    _myContentArray = [NSMutableArray new];
    
    
}
#pragma mark -- ==========网络请求==========
-(void)requestRecivedData
{
    NSString* url = [CommonMethod UrlAddAction:Url_Message_MyCommentList];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:@"receive" forKey:@"type"];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        
        
        if([jsonDic[@"status"] isEqual:@1]){
//            id result = jsonDic[@"data"][@"data"];//只有20条数据
//            
//            if([result isEqualToString:@""]){
//                [self dismiss];
//                return ;
//            }
//            
            //装载全部我发出的信息  装载装载全部回复信息
            if([_myContentArray count] > 0 ){
                [_myContentArray removeAllObjects];
            }
            if([_otherContentArray count] > 0){
                [_otherContentArray removeAllObjects];
            }
            for(int i = 0 ; i < [_partDataSourse count]; i++){
                NSDictionary* oneCellInfo = [_partDataSourse objectAtIndex:i]; //一条cell信息
                NSString* oneContentStr = [oneCellInfo valueForKey:@"content"];
                [_otherContentArray addObject:oneContentStr];
                
                NSString* oneSourceContentStr = [[oneCellInfo valueForKey:@"sourceInfo"]valueForKey:@"feed_content"];
                [_myContentArray addObject:oneSourceContentStr];
            }
            
            [self.tableView reloadData];
            
        }
        
        // [self.postTableView reloadData];
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"发出的评论请求错误%@",error);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_partDataSourse count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    UINib *nib=[UINib nibWithNibName:@"RecivedCommenCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifer];
    
    RecivedCommenCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell){
        cell = [[RecivedCommenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    //添加开始
    cell.middleLine.backgroundColor = APPBackColor;
    
    //数据源 有数据
    if(_partDataSourse.count > 0){
        //处理头像1
        NSString* image1Str = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"user_info"]valueForKey:@"avatar_big"];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:image1Str] placeholderImage: PLACEHOLDERIMAGE];
        //处理名字1
        NSString* name1 = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"user_info"]valueForKey:@"uname"];
        cell.nameLabel1.text = name1;
        //处理时间1
        NSString*time1 = [[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"ctime"];
        cell.timeLabel1.text = [CommonMethod getTimeStrWithTimeStamp:time1];
        //处理内容1
        NSString* contentStr1 =[_myContentArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithData:[contentStr1 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        cell.textView1.attributedText = attributedString1;
        cell.textView1.backgroundColor = RGB(240, 240, 242);
        
        
        
        //处理头像1
        NSString* image0Str = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"sourceInfo"]valueForKey:@"avatar_big"];
        [cell.imageView0 sd_setImageWithURL:[NSURL URLWithString:image0Str] placeholderImage:PLACEHOLDERIMAGE];
        
        //处理名字1
        NSString* name0 = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"sourceInfo"]valueForKey:@"uname"];
        cell.nameLabel0.text = name0;
        
        //处理时间1
        NSString* time0 = [[[_partDataSourse objectAtIndex:indexPath.row]valueForKey:@"sourceInfo"]valueForKey:@"ctime"];
        cell.timeLabel0.text = [CommonMethod getTimeStrWithTimeStamp:time0];
        //处理内容1
        NSString* contentStr0 =[_otherContentArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString0 = [[NSAttributedString alloc] initWithData:[contentStr0 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        cell.textView0.attributedText = attributedString0;
        cell.textView0.backgroundColor = RGB(240, 240, 242);
    }//如果数据源个数大于0 条件结束

    //添加结束
    
    
    CGFloat height0 = [self heightForTextView:0 IndexPath:indexPath];
    CGFloat height1 = [self heightForTextView:1 IndexPath:indexPath];
    
    //修改textView0高度
    if(height0>30){
        cell.textView0.height = height0;
    }else{
        cell.textView0.height = 30;
    }
    
    
    //修改中间线条高度
    cell.middleLine.top = 102 + (height0 - 30); //cell.middleLine.top = 102
    
    //修改第二张头像
    cell.imageView1.top = 115 + (height0 - 30);//cell.imageView1.top
    //修改第二个title
    cell.nameLabel1.top = 120 + (height0 - 30);//cell.nameLabel1.top
    
    //修改第textView1高度
    cell.textView1.top = 149 + (height0 - 30);//cell.textView1.top
    
    if(height1>45){
        cell.textView1.height = height1;
    }else{
        cell.textView1.height = 45;
    }
    
    //修改第二个时间
    cell.timeLabel1.top = 202 + (height0 - 30) + (height1 - 45);//cell.timeLabel1.top
    
    //修改底部线条
    cell.bottomLine.top = 248 + (height0 - 30) + (height1 - 45);//cell.bottomLine.top
    
    cell.height = 250 + (height0 - 30) +  (height1 - 45);//cell.height
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height0 = [self heightForTextView:0 IndexPath:indexPath]; //收到的
    CGFloat height1 = [self heightForTextView:1 IndexPath:indexPath]; //我的
    CGFloat result = 250 + (height0 - 30) +  (height1 - 45);
    
    return result;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
 评论demo[4097:257284] 63.000000
 2015-11-13 17:40:50.443 评论demo[4097:257284] 79.000000
 2015-11-13 17:40:50.450 评论demo[4097:257284] 79.000000
 2015-11-13 17:40:50.456 评论demo[4097:257284] 63.000000
 2015-11-13 17:40:50.463 评论demo[4097:257284] 94.000000*/

/*
 48.000000
 2015-11-13 17:42:21.081 评论demo[4117:258692] 94.000000
 2015-11-13 17:42:21.088 评论demo[4117:258692] 79.000000
 2015-11-13 17:42:21.095 评论demo[4117:258692] 141.000000
 2015-11-13 17:42:21.101 评论demo[4117:258692] 79.000000*/

-(CGFloat)heightForTextView:(int)MyOrOther//传入
                  IndexPath:(NSIndexPath*)indexPath //传入索引
{
    if(MyOrOther==0){//收到的
        NSString* contentStr =[_otherContentArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UITextView* tempLabel = [UITextView new];
        tempLabel.width = SCREENWIDTH - 16;
        tempLabel.height = 0;
        tempLabel.attributedText = attributedString;
        return tempLabel.contentSize.height;
        
    }else{//我的
        NSString* contentStr =[_myContentArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UITextView* tempLabel = [UITextView new];
        tempLabel.width = SCREENWIDTH - 16;
        tempLabel.height = 0;
        tempLabel.attributedText = attributedString;
        return tempLabel.contentSize.height;
        
    }
    
}




@end
