//
//  AppDelegate.m
//  TravelInHK
//
//  Created by qianfeng on 13-7-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ToolViewController.h"
#import "NearbyViewController.h"
#import "CollectViewController.h"
#import "MoreViewController.h"
#import "LeveyTabBarController.h"
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    RootViewController * rvc=[[RootViewController alloc]init];
    UINavigationController *rvc1=[[UINavigationController alloc]initWithRootViewController:rvc];
  
    ToolViewController *tvc=[[ToolViewController alloc]init];
    UINavigationController *tvc1=[[UINavigationController alloc]initWithRootViewController:tvc];
    NearbyViewController *nvc=[[NearbyViewController alloc]init];
    UINavigationController *nvc1=[[UINavigationController alloc]initWithRootViewController:nvc];
    CollectViewController *cvc=[[CollectViewController alloc]init];
    UINavigationController *cvc1=[[UINavigationController alloc]initWithRootViewController:cvc];
    MoreViewController *mvc=[[MoreViewController alloc]init];
    UINavigationController *mvc1=[[UINavigationController alloc]initWithRootViewController:mvc];
    NSArray *array=[NSArray arrayWithObjects:rvc1,tvc1,nvc1,cvc1,mvc1,nil];
    UITabBarController *tab=[[UITabBarController alloc]init];
    tab.viewControllers=array;
   
  
    
    
    self.window.rootViewController=tab;
    
    
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
