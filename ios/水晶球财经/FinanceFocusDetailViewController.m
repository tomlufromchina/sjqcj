//
//  FinanceFocusDetailViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/3.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "FinanceFocusDetailViewController.h"
#import "UIViewExt.h"
#import "AFNetworking.h"
#import "CommonMethod.h"

@interface FinanceFocusDetailViewController ()
{
    NSDictionary* _NewsInfoDIc;
}
@end

@implementation FinanceFocusDetailViewController


-(void)viewWillAppear:(BOOL)animated
{
     [self show];
     [self requestNewsData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.view.backgroundColor = APPBackColor;
    
    [self rebuildUI];
    [self initGloableData];
   
}

-(void)rebuildUI
{
    self.view.width =SCREENWIDTH;
    self.view.height = SCREENHEIGHT;
    
    self.titleLabel.centerX = SCREENWIDTH*0.5;
    self.timeLabel.left = 10;
    self.textView.top = 70;
    self.textView.left = 10;
    self.textView.width = SCREENWIDTH - 20;
    self.textView.height = SCREENHEIGHT- 70-49 - 64 -10; //SCREENHEIGHT - text.to - bottomView.hegit-间隔
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT*1.5);
    self.textView.backgroundColor = [UIColor whiteColor];
    
   
    self.bottomView.width = SCREENWIDTH; //高度49
    self.bottomView.left = 0;
    self.bottomView.bottom = self.view.bottom -64;
    self.bottomView.backgroundColor = [UIColor orangeColor];
    
    
    self.textFeild.left = 30;
    self.publicButton.right = SCREENWIDTH - 30;
    self.publicButton.layer.borderWidth = 1;
    self.publicButton.layer.borderColor = [UIColor greenColor].CGColor;
    self.publicButton.layer.cornerRadius = 5;
}
-(void)initGloableData
{
    _NewsInfoDIc = [NSDictionary new];
}

-(void)requestNewsData
{
    //Url_FinanceFocus_OneNews
    NSString* url = [CommonMethod UrlAddAction:Url_FinanceFocus_OneNews]; //CommonMethod.h
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:self.financeID forKey:@"news_id"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if(jsonDic.count > 0){
            _NewsInfoDIc = jsonDic[@"data"];
           // NSLog(@"%@",_NewsInfoDIc);
            [self loadUIWithData]; //加载数据
        }
        [self dismiss];
        //NSLog(@"财经新闻新闻返回数据：%@",_newsArray);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"财经焦点新闻详情请求错误%@",error);
        [self showError];
    }];

}

-(void)loadUIWithData
{
    //标题news_title
    self.titleLabel.text = [_NewsInfoDIc valueForKey:@"news_title"];
    
    //创建时间
    self.timeLabel.text = [CommonMethod getTimeStrWithTimeStamp:[_NewsInfoDIc valueForKey:@"created"]];
   //内容
    
    NSString* contentStr = [_NewsInfoDIc valueForKey:@"news_content"];
     NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    self.textView.attributedText = attributedString;
    //普通字符串
   // NSString* Str = @“<>()11111111KKKKKKKKKK";
    
    //转化为富文本字符串
//    NSAttributedString *attributedString = [[NSAttributedStringalloc] initWithData:[Str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}documentAttributes:nilerror:nil];
//    //显示
//    textView.attributedText = attributedString;
    
}
-(void)rightItemAction
{
    NSLog(@"33");
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

@end
