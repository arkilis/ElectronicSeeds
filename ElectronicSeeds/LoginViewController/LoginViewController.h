//
//  LoginViewController.h
//  Shew_v4
//
//  Created by Ben Liu on 12/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "Common.h"


@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField  *textEmail;
@property (strong, nonatomic) IBOutlet UITextField  *textPassword;
@property (strong, nonatomic) IBOutlet UIButton     *btnLogin;

@end
