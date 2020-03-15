//
//  BaseViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"
#import "SVProgressHUD.h" //progress过程提示
#import"SDWebImage/SDWebImageManager.h"//内存不足的时候自动清空图片缓存


@interface BaseViewController ()

@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    SDImageCache *imageCache = [SDWebImageManager sharedManager].imageCache;
    NSString *cache = [NSString stringWithFormat:@"%.1fM", imageCache.getSize / (1024 * 1024.0)];
    if (![cache isEqualToString:@"0.0M"]) {
        // clearDisk清文件
        [[SDImageCache sharedImageCache] clearDisk];
        // clearMemory清内存。
        [[SDImageCache sharedImageCache] clearMemory];
        
    } else {
    }
    
    // Dispose of any resources that can be recreated.
}

- (void)show  //不会释放单例
{
   //  [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"加载中..."];
}

- (void)showImage:(UIImage *)image status:(NSString *)string //不会释放单例
{
    [SVProgressHUD showImage:image status:string];
    
}


-(void)showSuccess  //会释放单例
{
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
}

-(void)showError   //会释放单例
{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
}


- (void)dismiss  //取消 单例
{
    [SVProgressHUD dismiss];
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


@end
