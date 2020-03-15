//
//  NicePostTableViewCell.h
//  Crystal
//
//  Created by Tom lu on 15/10/27.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NicePostTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *titleLabel; //标题
@property (strong, nonatomic) IBOutlet UILabel *authorLabel; //作者


@property (strong, nonatomic) IBOutlet UIImageView *commentImageView;  //评论
@property (strong, nonatomic) IBOutlet UILabel *commentCountLabel; //评论数


@property (strong, nonatomic) IBOutlet UIImageView *headImageView; //头部图片

@end
