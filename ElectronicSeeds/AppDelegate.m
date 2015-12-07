//
//  AppDelegate.m
//  ElectronicSeeds
//
//  Created by Ben Liu on 18/09/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "AppDelegate.h"
#import "Common/Common.h"
#import "UserInfo/UserInfo.h"
#import "GoogleMaps/GoogleMaps.h"
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UserInfo *userinfo= [Common deSerializeUserInfo];
    if (userinfo==nil || userinfo.userID==nil) {
        // Override point for customization after application launch.
        self.window.rootViewController = [self pages];
    }
    
    // add google map sdk key
    [GMSServices provideAPIKey:@"AIzaSyAtopFU0Fc5q6qeQNw2u-o5JiJRTfbmJRU"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
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

#pragma pages
- (OnboardingViewController *)pages{
    OnboardingContentViewController *firstPage= [OnboardingContentViewController contentWithTitle:nil body:nil image:[UIImage imageNamed:@"page1Iphone5s_1"]  buttonText:nil action:nil];
    firstPage.topPadding= 0;
    
    OnboardingContentViewController *secondPage= [OnboardingContentViewController contentWithTitle:nil body:nil image:[UIImage imageNamed:@"page2Iphone5s_1"] buttonText:@"Be With Us!" action:^{[self handleOnboardingCompletion];}];
    secondPage.topPadding=0;
    
    
    
    
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"background"] contents:@[firstPage, secondPage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.shouldMaskBackground = NO;
    //onboardingVC.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    //onboardingVC.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    
    onboardingVC.allowSkipping = YES;
    onboardingVC.skipHandler = ^{
        [self handleOnboardingCompletion];
    };
    return onboardingVC;
}

-(void) handleOnboardingCompletion{
    //self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainView= [storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    self.window.rootViewController= mainView;
    [self.window makeKeyAndVisible];
}

@end
