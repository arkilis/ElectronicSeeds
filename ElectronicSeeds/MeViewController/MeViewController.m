//
//  MeViewController.m
//  Gremlins
//
//  Created by Ben Liu on 26/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "MeViewController.h"


@implementation MeViewController

- (void)awakeFromNib
{
    //set up form
    self.formController.form = [[MeFXForm alloc] init];
}


// Save Bar Item
//  serialize the UserInfo Object

- (IBAction)btnSave:(id)sender {
    MeFXForm *form = self.formController.form;
    
    //NSString *szEmail=      form.account;   // actually I used preplaced value, you cannot get any value for it
    NSString *szSetting=    form.setting;
    NSArray *ary_category=  form.category;

    // get user info from previous user store, mainly for user id
    UserInfo *userinfo_pre = [[UserInfo alloc] init];
    userinfo_pre= [Common deSerializeUserInfo];
    
    if(userinfo_pre!= nil){
        // store the new data
        [Common serializeUserInfo:userinfo_pre.userID
                    withUserEmail:userinfo_pre.userEmail
                       withCredit:userinfo_pre.credit
                 withNotification:szSetting
                    withCategory:ary_category];
    }
     
    [SVProgressHUD showSuccessWithStatus:@"Saved Successfully"];

}


// Log out button
- (void)logout:(UITableViewCell<FXFormFieldCell> *)cell {
    
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Remove the local data
        // Need to replaced with UserInfo
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        

        [userDefaults removeObjectForKey:USER_PERSIST];
        
        /*
        [userDefaults removeObjectForKey:@"userID"];
        [userDefaults removeObjectForKey:@"userEmail"];
        [userDefaults removeObjectForKey:@"action"];
        [userDefaults synchronize];
         */

        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            // jump to login view
            LoginViewController  *logVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewControl"];
            [self presentViewController:logVC animated:NO completion:nil];
        });
    });
}




@end
