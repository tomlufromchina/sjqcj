//
//  AiTeMeViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/18.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "AiTeMeViewController.h"
#import "AiTeTableViewCell.h"
#import "UIViewExt.h"
@interface AiTeMeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _myListArray;
    NSMutableArray* _otherListArray;
}
@end

@implementation AiTeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT-64;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
    
    
    [self initGloabelData];
    [self.tableView reloadData];
}


-(void)initGloabelData
{
    _myListArray = [NSMutableArray new];
    _otherListArray = [NSMutableArray new];
    
    
    //后面会删的 测试数据
    
    _otherListArray = [NSMutableArray arrayWithObjects:
                       @"我的我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我我的我的我的我的我的我我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的",
                       
                       
                       @"我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的",
                       
                       @"我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的我的", nil];
    
    
    _myListArray = [NSMutableArray arrayWithObjects:
                       @"的我的我的我的我的我的我的的我的我的我的我的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的我的我的我的我的我的我的我的我的我的我的我的我的我的",
                       
                       
                       @"我的我的我的我的我的我的我的我的我的我的我的我别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的的我的我的我的我的",
                       
                       @"我的我的我的我的我的我的我的我的我的我的我的我别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的别人的的我的我的我的我的我的我的我的我的", nil];
    
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _otherListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifer = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    UINib *nib=[UINib nibWithNibName:@"AiTeTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifer];
  
    AiTeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell){
        cell = [[AiTeTableViewCell alloc]init];
    }
    
    //处理数据
    
    //处理高度
    CGFloat height0 = [self heightForTextView:0 IndexPath:indexPath]; //别人的
    CGFloat height1 = [self heightForTextView:1 IndexPath:indexPath]; //我的
    
    
         //处理textView高度判断
    if(height0 > 27){
        cell.textView0.height = height0;
    }else{
        height0 = 27;
    }
    
    //对textView1高度判断
    if(height1 > 67){
        cell.textView1.height = height1;
    }else{
        height1 = 67;
    }
    
    
         //处理白色背景视图下移 以及高度
    cell.backgroundView1.top = 94 + (height0 - 27); //白色背景向下移动
    cell.backgroundView1.height =  125 + (height1 - 67);
    
   
    //三个button 以及底部Line 向下移动  h1+h2
    cell.replayButton.top = cell.goodButton.top = cell.commentButton.top = 227 +  (height0 - 27) +  (height1 - 67) ;
    cell.buttomView.top = 247 + (height0 - 27) +  (height1 - 67) ;
    
    
    cell.height = 250 + (height0 - 27) + (height1 - 67);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height0 = [self heightForTextView:0 IndexPath:indexPath]; //收到的
    CGFloat height1 = [self heightForTextView:1 IndexPath:indexPath]; //我的
    CGFloat result = 250 + (height0 - 27) +  (height1 - 67); //textView0 = 27,textView1 = 67
    return result;

}


-(CGFloat)heightForTextView:(int)MyOrOther//传入
                  IndexPath:(NSIndexPath*)indexPath //传入索引
{
    if(MyOrOther==0){//别人的
        NSString* contentStr =[_otherListArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UITextView* tempLabel = [UITextView new];
        tempLabel.width = SCREENWIDTH - 16;
        tempLabel.height = 0;
        tempLabel.attributedText = attributedString;
        return tempLabel.contentSize.height;
        
    }else{//我的
        NSString* contentStr =[_myListArray objectAtIndex:indexPath.row];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UITextView* tempLabel = [UITextView new];
        tempLabel.width = SCREENWIDTH - 16;
        tempLabel.height = 0;
        tempLabel.attributedText = attributedString;
        return tempLabel.contentSize.height;
        
    }
    
}


@end
