//
//  GameMoreViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/26.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "GameMoreViewController.h"
#import  "UIViewExt.h"
#import "GameTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface GameMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
   
}
@end

@implementation GameMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT - 64;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.delegate = (id)self;
    self.tableView.dataSource = (id)self;
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsArray count];
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
    
        if([self.itemsArray count]>0){
    
            
          
           {
                NSDictionary* onePerson = [self.itemsArray objectAtIndex:indexPath.row];
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
                NSString* week = [onePerson valueForKey:@"list_price"];
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





@end
