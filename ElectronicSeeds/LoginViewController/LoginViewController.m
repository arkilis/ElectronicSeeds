//
//  LoginViewController.m
//  Shew_v4
//
//  Created by Ben Liu on 12/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import "LoginViewController.h"



@implementation LoginViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // lock screen rotation
    //[self restrictRotation: YES];
}

// Button Login
- (IBAction)btnLogin:(UIButton *)sender {
    if([[self.textEmail text] isEqualToString:@""] || [[self.textPassword text] isEqualToString:@""] ) {
        [Common alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
    } else {
        // Show loading image
        [SVProgressHUD show];

        
        [Common getLogin:[self.textEmail text] password:[self.textPassword text]
          withCompletion:^(UserInfo* userinfo){
            
              UserInfo *userInfo= userinfo;
              if(userInfo.userID!=0) { // Login succeed
                  [SVProgressHUD dismiss];
                  UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                  
                  // For later jump action
                  NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
                  NSString *action = [userDefault objectForKey:@"action"];
                  
                  
                  TabBarViewController *tbc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainTabBar"];
                  
                  if([action isEqualToString:@"post"]){
                      [tbc setSelectedIndex:2];
                      [self presentViewController:tbc animated:YES completion:nil];
                  }else{   // to avoid crash, jump to me when finding actions except "post", as "me" is used more often
                      [tbc setSelectedIndex:4];
                      [self presentViewController:tbc animated:YES completion:nil];
                  }
              }
        }];
    }
}


// Button go to registration page
- (IBAction)btnRegistration:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [Common getRegistrationURL]]];
}

// Button go to forget password page
- (IBAction)btnForgetPassword:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [Common getForgetPasswordURL]]];
}

// Button view our site
- (IBAction)btnGoWebsite:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [Common getWebSiteURL]]];
}


// Test button connect to nearby table view controller
- (IBAction)NearByList:(UIButton *)sender {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController  *nav= [mainStoryBoard instantiateViewControllerWithIdentifier:@"nearbyTableListNav"];
    [self presentViewController:nav animated:YES completion:nil];
}



// Test login
/*
- (IBAction)testLogin:(UIButton *)sender {
    self.textEmail.text= @"arkilis@gmail.com";
    self.textPassword.text = @"wahaha";
}
*/

// dismiss the keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textEmail resignFirstResponder];
    [self.textPassword resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField== self.textEmail) {
        [self.textEmail resignFirstResponder];
    }
    if (textField== self.textPassword) {
        [self.textPassword resignFirstResponder];
    }
    return NO;
}

/*
// Lock screen rotation
-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
}
*/

// Cancel Login and return to the Now View
- (IBAction)btnCancel:(id)sender {
    TabBarViewController *tbvc= [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    tbvc.selectedIndex=0;
    [self presentViewController:tbvc animated:NO completion:nil];
}



@end

























