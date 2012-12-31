//
//  AppDelegate.m
//  Combos
//
//  Created by Rolf Chen on 18/03/12.
//  Copyright (c) 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import "AppDelegate.h"
#import "ComboViewController.h"
#import "YoutubeViewController.h"
#import "GymViewController.h"
#import "TipsViewController.h"
#import "BoxingTipsViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabController = _tabController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.    
    
    //COMBO 
    ComboViewController *comboViewControl = [[ComboViewController alloc] initWithNibName:@"ComboViewController" bundle:nil];
    UINavigationController *comboNavController = [[UINavigationController alloc] initWithRootViewController:comboViewControl];
    [comboNavController setNavigationBarHidden:YES];
    comboNavController.title = @"Combos";
    comboNavController.tabBarItem.image = [UIImage imageNamed:@"ComboIcon.png"];
    
    //BoxingTips
    BoxingTipsViewController *boxingViewControl = [[BoxingTipsViewController alloc] initWithNibName:@"BoxingTipsViewController" bundle:nil];
    UINavigationController *boxingNavController = [[UINavigationController alloc] initWithRootViewController:boxingViewControl];
    boxingNavController.title = @"Boxing Basics";
    boxingNavController.tabBarItem.image = [UIImage imageNamed:@"TipsIcon.png"]; //TEMP
    
    //YOUTUBE
    YoutubeViewController *youtubeViewControl = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil];
    UINavigationController *youtubeNavController = [[UINavigationController alloc] initWithRootViewController:youtubeViewControl];
    youtubeNavController.title = @"Youtube";
    youtubeNavController.tabBarItem.image = [UIImage imageNamed:@"YouTubeIcon.png"];
    
    //Gym
    GymViewController *gymViewControl = [[GymViewController alloc] initWithNibName:@"GymViewController" bundle:nil];
    UINavigationController *gymNavController = [[UINavigationController alloc] initWithRootViewController:gymViewControl];
    gymNavController.title = @"My Gym";
    
    self.tabController = [[UITabBarController alloc] init];
    [self.tabController setViewControllers:[NSArray arrayWithObjects:comboNavController, boxingNavController, youtubeNavController, gymNavController, nil]];
    self.tabController.tabBar.tintColor = [UIColor colorWithRed:(151.0f/255.0f) green:(199.0f/255.0f) blue:(62.0f/255.0f) alpha:1];
    self.tabController.tabBar.selectedImageTintColor = [UIColor whiteColor];
    
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
