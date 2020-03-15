//
//  RotateViewController.m
//  Crystal
//
//  Created by Tom lu on 15/10/26.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "RotateViewController.h"
#import "UIViewExt.h"
@interface RotateViewController ()<UIScrollViewDelegate>
{
    UIPageControl* _pageControl;
}
@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.contentSize = CGSizeMake(3*SCREENWIDTH, self.scrollView.frame.size.height);
    for(int i = 0; i < 3; i++){
        UIImageView* imageView = [UIImageView new];
        [imageView setFrame:CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
        [imageView setTag:i];
        [self.scrollView addSubview:imageView];
        NSString* imageName = [NSString stringWithFormat:@"Scroll_%d",i];
        imageView.image = [UIImage imageNamed:imageName];
        
        if(2 == i){
            imageView.backgroundColor = [UIColor redColor];
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
        }

    }
    
    
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    _pageControl.numberOfPages = 3;
    _pageControl.backgroundColor = [UIColor lightGrayColor];
    _pageControl.currentPage = 0;
    [self.view addSubview:_pageControl];
    _pageControl.centerX = self.view.centerX;
    _pageControl.centerY = SCREENHEIGHT - 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        NSLog(@"滚动中");
     //    计算页码
        // 页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
         CGFloat scrollviewW =  scrollView.frame.size.width;
         CGFloat x = scrollView.contentOffset.x;
         int page = (x + scrollviewW / 2) /  scrollviewW;
         _pageControl.currentPage = page;
}

-(void)tapAction
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(lsatPageTapAction)])
    {
        [self.delegate lsatPageTapAction];
    }
}


@end


