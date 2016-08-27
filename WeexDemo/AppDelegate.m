//
//  AppDelegate.m
//  WeexDemo
//
//  Created by Administrator on 16/8/8.
//  Copyright © 2016年 XuYouhong. All rights reserved.
//

#import "AppDelegate.h"
#import "YHImageLoader.h"
#import "YHEventHandler.h"
#import <WeexSDK.h>
#import <WXDevTool.h>
#import "YHMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self initWeexSDK];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[self mainViewController]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)initWeexSDK{
    [WXDevTool setDebug:YES];
    //business configuration
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    //init sdk enviroment
    [WXSDKEngine initSDKEnviroment];
    //注册网络图片加载器
    [WXSDKEngine registerHandler:[YHImageLoader new] withProtocol:@protocol(WXImgLoaderProtocol)];
    //注册事件处理
    [WXSDKEngine registerHandler:[YHEventHandler new] withProtocol:@protocol(WXEventModuleProtocol)];
    [WXSDKEngine registerModule:@"event" withClass:[YHEventHandler class]];
    //set the log level
    [WXLog setLogLevel:WXLogLevelDebug];
}

- (UIViewController *)mainViewController{
    UIViewController *mainVC = [[YHMainViewController alloc]init];
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"AppDelegatePage" withExtension:@"js"];
    mainVC.navigationItem.title = @"首页";
    ((YHMainViewController *)mainVC).url = url;
    return mainVC;
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
