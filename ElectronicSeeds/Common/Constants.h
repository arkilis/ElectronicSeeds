//
//  Constants.h
//  ElectronicSeeds
//
//  Created by Ben Liu on 19/09/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#ifndef ElectronicSeeds_Constants_h
#define ElectronicSeeds_Constants_h


// URL constants
static NSString * const szURLMain                   = @"http://www.electronicseeds.com/";
static NSString * const szURLLogin                  = @"appScript/login_app.php";
static NSString * const szURLGetNear                = @"appScript/getnearlocations.php";
static NSString * const szURLGetFuture              = @"appScript/getFutureSeeds.php";
static NSString * const szURLSendStats              = @"appScript/adStats.php";
static NSString * const szURLRegistration           = @"index.php/mydefault/registerView";
static NSString * const szURLForgotPassword         = @"index.php/mydefault/sendResetPasswordEmailView";
static NSString * const szURLPostNewSeed            = @"index.php/mydefault/user_post_a_new_station";
static NSString * const szURLUploadImage            = @"index.php/fileupload/upload_file";


// Google Map init Zoom
static int const iGoogleMapZoomIn                   = 14;


// NSUserDefaults key
static NSString * const szKeySeedsArray             = @"Seeds";

// NSUserDefaults User Info key
static NSString * const szKeyUserInfo               = @"userInfo";
static NSString * const szKeyUserInfoID             = @"userID";
static NSString * const szKeyUserInfoEmail          = @"userEmail";
static NSString * const szKeyUserInfoCredit         = @"userCredit";
static NSString * const szKeyUserInfoNotification   = @"userNotificationSetting";
static NSString * const szKeyUserInfoCategory       = @"userCatetoryOption";


#endif
