//
//  JHAppDelegate.m
//  百度音乐
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHAppDelegate.h"
#import "JHMusicsViewController.h"
#import "JHNavigationController.h"

@implementation JHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    // 3.添加子控制器到导航控制器中
    JHMusicsViewController *musicVc = [[JHMusicsViewController alloc] init];
    // 1. 创建导航控制器
    JHNavigationController *nav = [[JHNavigationController alloc] initWithRootViewController:musicVc];
    // 2.设置window的根控制器
    self.window.rootViewController = nav;
    
    
    // 4.显示window
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 进入后台可以继续工作
    UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:taskId];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
