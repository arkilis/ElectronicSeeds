//
//  UserInfo.h
//  Gremlins
//
//  Created by Ben Liu on 19/08/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <Foundation/Foundation.h>


////////////////////////////////////////////////////////////////////////////////////////////
//  Persistence Variable Name

#define     USER_PERSIST            @"userInfo"
#define     USER_PERSIST_ID         @"userID"
#define     USER_PERSIST_EMAIL      @"userEmail"
#define     USER_PERSIST_CREDIT     @"userCredit"
#define     USER_PERSIST_NOTI       @"userNotificationSetting"
#define     USER_PERSIST_CATE       @"userCatetoryOption"

////////////////////////////////////////////////////////////////////////////////////////////


@interface UserInfo : NSObject

@property (nonatomic, strong) NSString  *userID;
@property (nonatomic, strong) NSString  *userEmail;
@property (nonatomic, strong) NSString  *credit;
@property (nonatomic, strong) NSString  *notificationOption;    // notification on or off
@property (nonatomic, strong) NSArray   *categoryOption;        // Contains categories that user set

@end
