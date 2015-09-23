//
//  TabBarViewController.m
//  Gremlins
//
//  Created by Ben Liu on 23/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate= self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    switch (tabBarController.selectedIndex) {
        // Now
        case 0:{
            NSLog(@"selected 0");
            break;
        }
            
        // Future
        case 1:{
            NSLog(@"selected 1");
            break;
        }
            
        // Post
        case 2:{
            
            NSLog(@"selected 2 - post tab");
            UserInfo *userinfo= [Common deSerializeUserInfo];
            if (userinfo==nil || userinfo.userID==nil) {
                // set the shard object -- remember the view that going to go.
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:@"post" forKey:@"action"];
                [userDefaults synchronize];
                
                // Go to the login view
                /*
                LoginViewController  *logVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewControl"];
                [self presentViewController:logVC animated:NO completion:nil];
                 */
            }
            break;
        }
            
        // Collection
        case 3:{
            NSLog(@"selected 3");
            break;
        }
        // Me
        case 4: {
            UserInfo *userinfo= [Common deSerializeUserInfo];
            if (userinfo==nil || userinfo.userID==nil) {
                // set the shard object -- remember the view that going to go.
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:@"me" forKey:@"action"];
                [userDefaults synchronize];
                
                // Go to the login view
                /*
                LoginViewController  *logVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewControl"];
                [self presentViewController:logVC animated:NO completion:nil];
                 */
            }
            break;
        }
        default:
            break;
    }
}


@end
