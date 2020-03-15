//
//  AppDelegate.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "AppDelegate.h"
#import "RotateViewController.h"
#import "HomePageViewController.h" //首页
#import "NewsViewController.h"    //资讯
#import "MessageViewController.h" //消息
#import "StockBarViewController.h"//股吧
#import "UserCenterViewController.h" //用户中心

@interface AppDelegate ()<firstScrollDelegate,UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     //初始化window
     self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
     [self.window makeKeyAndVisible];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        [self firstTimeRun];
    }else{ //不是第一次启动 进入主界面
        [self buildAppUI];
    }

    return YES;
}

//第一次运行程序
-(void)firstTimeRun
{
    RotateViewController* rotateVC = [RotateViewController new];
    rotateVC.delegate = (id)self;
    self.window.rootViewController = rotateVC;
}

// 轮播图中的代理方法
-(void)lsatPageTapAction
{
    [self buildAppUI];
}

-(void)buildAppUI
{
    UITabBarController* tabBarController = [[UITabBarController alloc]init];
    //为tabbar增加背景颜色
    UIView *tapBarbackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 49)];
    tapBarbackView.backgroundColor = RGB(248, 248, 248);
    [tabBarController.tabBar insertSubview:tapBarbackView atIndex:0];
    tabBarController.tabBar.opaque = YES;
    
    tabBarController.delegate = (id)self;
    tabBarController.tabBar.translucent = NO;
    
    //创建tabBar管理的viewController
    HomePageViewController* homePageVC = [[HomePageViewController alloc]init];
    NewsViewController*  newsVC = [[NewsViewController alloc]init];
    MessageViewController* messageVC = [[MessageViewController alloc]init];
    StockBarViewController*  StockVC = [[StockBarViewController alloc]init];
    UserCenterViewController*   userVC =  [[UserCenterViewController alloc]init];
    
    //tabbaritem1图片
    UIImage* barItem1Image = [UIImage imageNamed:@"tabbar_home"];
    UIImage* barItem1ImageSelect = [UIImage imageNamed:@"tabbar_home_tap"];
    
    barItem1Image = [barItem1Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem1ImageSelect = [barItem1ImageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建tabbaritem1 绑定VC
    UITabBarItem* tabBarItem1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:barItem1Image selectedImage:barItem1ImageSelect];
    homePageVC.tabBarItem = tabBarItem1;
    
    
    //tabbaritem1 文字颜色
    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //tabbaritem2图片
    UIImage* barItem2Image = [UIImage imageNamed:@"tabbar_sort"];
    UIImage* barItem2ImageSelect = [UIImage imageNamed:@"tabbar_sort_tap"];
    
    barItem2Image = [barItem2Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem2ImageSelect = [barItem2ImageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建tabbaritem1 绑定VC
    UITabBarItem* tabBarItem2 = [[UITabBarItem alloc]initWithTitle:@"资讯" image:barItem2Image selectedImage:barItem2ImageSelect];
    newsVC.tabBarItem = tabBarItem2;
    
    
    //tabbaritem1 文字颜色
    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    //tabbaritem3图片
    UIImage* barItem3Image = [UIImage imageNamed:@"tabbar_shopping"];
    UIImage* barItem3ImageSelect = [UIImage imageNamed:@"tabbar_shopping_tap"];
    
    barItem3Image = [barItem3Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem3ImageSelect = [barItem3ImageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建tabbaritem1
    UITabBarItem* tabBarItem3 = [[UITabBarItem alloc]initWithTitle:@"消息" image:barItem3Image selectedImage:barItem3ImageSelect];
    messageVC.tabBarItem = tabBarItem3;
    
    //tabbaritem1 文字颜色
    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    
    //tabbaritem4图片
    UIImage* barItem4Image = [UIImage imageNamed:@"tabbar_home"];
    UIImage* barItem4ImageSelect = [UIImage imageNamed:@"tabbar_home_tap"];
    
    barItem4Image = [barItem4Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem4ImageSelect = [barItem4ImageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建tabbaritem4
    UITabBarItem* tabBarItem4 = [[UITabBarItem alloc]initWithTitle:@"股吧" image:barItem4Image selectedImage:barItem4ImageSelect];
    StockVC.tabBarItem = tabBarItem4;
    
    //tabbaritem1 文字颜色
    [tabBarItem4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [tabBarItem4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    //tabbaritem5图片
    UIImage* barItem5Image = [UIImage imageNamed:@"tabbar_shopping"];
    UIImage* barItem5ImageSelect = [UIImage imageNamed:@"tabbar_shopping_tap"];
    
    barItem5Image = [barItem5Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem5ImageSelect = [barItem5ImageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建tabbaritem5
    UITabBarItem* tabBarItem5 = [[UITabBarItem alloc]initWithTitle:@"我的" image:barItem5Image selectedImage:barItem5ImageSelect];
    userVC.tabBarItem = tabBarItem5;
    
    //tabbaritem1 文字颜色
    [tabBarItem5 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [tabBarItem5 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController* nc1 = [[UINavigationController alloc]initWithRootViewController:homePageVC];
    UINavigationController* nc2 = [[UINavigationController alloc]initWithRootViewController:newsVC];
    UINavigationController* nc3 = [[UINavigationController alloc]initWithRootViewController:messageVC];
    UINavigationController* nc4 = [[UINavigationController alloc]initWithRootViewController:
                                   StockVC];
    UINavigationController* nc5 = [[UINavigationController alloc]initWithRootViewController:
                                   userVC];
    
    
    //navi  最开始用的 @"navBar" (雅黑) 这种颜色   后换成粉蓝色
    [nc1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav248"] forBarMetrics:UIBarMetricsDefault];
    [nc2.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav248"] forBarMetrics:UIBarMetricsDefault];
    [nc3.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav248"] forBarMetrics:UIBarMetricsDefault];
    [nc4.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav248"] forBarMetrics:UIBarMetricsDefault];
    [nc5.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav248"] forBarMetrics:UIBarMetricsDefault];
    
    nc1.navigationBar.tintColor = [UIColor blackColor];
    nc2.navigationBar.tintColor = [UIColor blackColor];
    nc3.navigationBar.tintColor = [UIColor blackColor];
    nc4.navigationBar.tintColor = [UIColor blackColor];
    nc5.navigationBar.tintColor = [UIColor blackColor];
    
    tabBarController.viewControllers = @[nc1,nc2,nc3,nc4,nc5];
    
    
    if(self.window.rootViewController){
        [self.window.rootViewController removeFromParentViewController];
        self.window.rootViewController = nil;
    }
    self.window.rootViewController = tabBarController;
   
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
