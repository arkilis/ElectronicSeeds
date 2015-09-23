//
//  UserInfo.m
//  Gremlins
//
//  Created by Ben Liu on 19/08/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize userID;
@synthesize userEmail;
@synthesize credit;
@synthesize notificationOption;
@synthesize categoryOption;


// Could be better tot have a fully defined UserInfo Class
// Make the userid and useremail as the property




- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.userID               forKey:USER_PERSIST_ID];
    [encoder encodeObject:self.userEmail            forKey:USER_PERSIST_EMAIL];
    [encoder encodeObject:self.credit               forKey:USER_PERSIST_CREDIT];
    [encoder encodeObject:self.notificationOption   forKey:USER_PERSIST_NOTI];
    [encoder encodeObject:self.categoryOption       forKey:USER_PERSIST_CATE];

    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    
    self.userID             = [decoder decodeObjectForKey:USER_PERSIST_ID];
    self.userEmail          = [decoder decodeObjectForKey:USER_PERSIST_EMAIL];
    self.credit             = [decoder decodeObjectForKey:USER_PERSIST_CREDIT];
    self.notificationOption = [decoder decodeObjectForKey:USER_PERSIST_NOTI];
    self.categoryOption     = [decoder decodeObjectForKey:USER_PERSIST_CATE];
    
    return self;
}

/*
// Return User ID
- (NSString*) getUserID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@USER_PERSIST_ID];

}

// Set User ID
- (NSString*) getUserID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@USER_PERSIST_ID];
    
}



// Return User Email
- (NSString*) getUserEmail{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@USER_PERSIST_EMAIL];
    
}
*/
@end
