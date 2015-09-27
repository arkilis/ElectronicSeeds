//
//  Common.m
//  ElectronicSeeds
//
//  Created by Ben Liu on 19/09/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "Common.h"

@implementation Common



-(id)init {
    return [self initWithInput];
}

-(id)initWithInput {
    if (self = [super init]){
        /* perform your post-initialization logic here */
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

// Get the current location
//  return format: 1.2,-1.2
- (NSString *)deviceLocation
{
    NSString *szLocation = [NSString stringWithFormat:@"%f,%f",
                             self.locationManager.location.coordinate.latitude,
                             self.locationManager.location.coordinate.longitude];
    
    NSLog(@"Location: %@", szLocation);
    // debug
    if([szLocation isEqualToString:@"0.000000,0.000000"]){
        szLocation= @"-27.508962, 152.936869";
    }
    return szLocation;
}


// Get nearby Seeds array
//  return an array of nearby seeds block
-(void)getNearbySeedsArray: (NSString*)szLocation
            withCompletion:(void (^)(NSMutableArray* aryRes))completion {
    
    NSArray *aryLatLng= [szLocation componentsSeparatedByString:@","];
    NSMutableArray* aryNearBySeeds = [[NSMutableArray alloc] init];
    //aryNearBySeeds = [[NSMutableArray alloc] init];
    NSString* szURLNearBy= [NSString stringWithFormat:@"%@%@", szURLMain, szURLGetNear];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST: szURLNearBy
       parameters:@{
                    @"latitude"  : aryLatLng[0],
                    @"longitude" : aryLatLng[1]
                    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              // Have to debug: whether responseObject is json or not
              NSLog(@"JSON: %@", responseObject);
              
              // Parse the JSON
              NSLog(@"latitude:%@, longitude:%@", aryLatLng[0], aryLatLng[1]);
  
              for (int i = 0; i < [responseObject count]; i++)
              {
                  NSDictionary *jsonElement = responseObject[i];
                  
                  // Create a new location object and set its props to JsonElement properties
                  SeedModel* seed       = [[SeedModel alloc] init];
                  seed.seedID           = jsonElement[@"station_id"];
                  seed.seedName         = jsonElement[@"station_name"];
                  seed.latitude         = jsonElement[@"latitude"];
                  seed.longitude        = jsonElement[@"longitude"];
                  seed.fileURLUpload    = jsonElement[@"fileURLUpload"];
                  seed.fileURLDropbox   = jsonElement[@"fileURLDropbox"];
                  seed.range            = jsonElement[@"m"];
                  seed.postDateTime     = jsonElement[@"pos_date_time"];
                  seed.address          = jsonElement[@"address"];
                  seed.duration         = jsonElement[@"duration"];
                  seed.category         = jsonElement[@"category_name"];
                  seed.importance       = jsonElement[@"importance"];
                  
                  // Set expire date and time
                  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                  [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                  NSDate *postDateTime = [dateFormat dateFromString:seed.postDateTime];
                  NSDate *expireDatetime = [postDateTime dateByAddingTimeInterval:60*[seed.duration intValue]];
                  seed.expireDateTime = [dateFormat stringFromDate:expireDatetime];
                  
                  // Add this location to the locations array
                  [aryNearBySeeds addObject:seed];
              }
        
              if(completion)
                  completion(aryNearBySeeds);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Retrieve Nearby Seeds Error: %@", error);
              if(completion)
                  completion(aryNearBySeeds);
                
          }];
}


// Get nearby Seeds array
//  return an array of future seeds block
-(void)getFutureSeedsArray: (NSString*)szLocation
            withCompletion:(void (^)(NSMutableArray* aryRes))completion {
    
    NSArray *aryLatLng= [szLocation componentsSeparatedByString:@","];
    NSMutableArray* aryNearBySeeds = [[NSMutableArray alloc] init];
    //aryNearBySeeds = [[NSMutableArray alloc] init];
    NSString* szURLNearBy= [NSString stringWithFormat:@"%@%@", szURLMain, szURLGetFuture];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST: szURLNearBy
       parameters:@{
                    @"latitude"  : aryLatLng[0],
                    @"longitude" : aryLatLng[1]
                    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              // Have to debug: whether responseObject is json or not
              NSLog(@"JSON: %@", responseObject);
              
              // Parse the JSON
              NSLog(@"latitude:%@, longitude:%@", aryLatLng[0], aryLatLng[1]);
              
              for (int i = 0; i < [responseObject count]; i++)
              {
                  NSDictionary *jsonElement = responseObject[i];
                  
                  // Create a new location object and set its props to JsonElement properties
                  SeedModel* seed       = [[SeedModel alloc] init];
                  seed.seedID           = jsonElement[@"station_id"];
                  seed.seedName         = jsonElement[@"station_name"];
                  seed.latitude         = jsonElement[@"latitude"];
                  seed.longitude        = jsonElement[@"longitude"];
                  seed.fileURLUpload    = jsonElement[@"fileURLUpload"];
                  seed.fileURLDropbox   = jsonElement[@"fileURLDropbox"];
                  seed.range            = jsonElement[@"m"];
                  seed.postDateTime     = jsonElement[@"pos_date_time"];
                  seed.address          = jsonElement[@"address"];
                  seed.duration         = jsonElement[@"duration"];
                  seed.category         = jsonElement[@"category_name"];
                  seed.importance       = jsonElement[@"importance"];
                  
                  // Set expire date and time
                  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                  [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                  NSDate *postDateTime = [dateFormat dateFromString:seed.postDateTime];
                  NSDate *expireDatetime = [postDateTime dateByAddingTimeInterval:60*[seed.duration intValue]];
                  seed.expireDateTime = [dateFormat stringFromDate:expireDatetime];
                  
                  // Add this location to the locations array
                  [aryNearBySeeds addObject:seed];
              }
              
              if(completion)
                  completion(aryNearBySeeds);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Retrieve Future Seeds Error: %@", error);
              if(completion)
                  completion(aryNearBySeeds);
              
          }];
}

// Login
//  return UserInfo object
+(void)getLogin: (NSString*)szEmail
       password: (NSString*)szPassword
 withCompletion: (void (^)(UserInfo*)) completion {
    
    UserInfo* userinfo= [[UserInfo alloc]init];
    NSString* szURLLoginRequest= [NSString stringWithFormat:@"%@%@", szURLMain, szURLLogin];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST: szURLLoginRequest
       parameters:@{
                    @"email"    : szEmail,
                    @"password" : szPassword
                    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Login return: %@", responseObject);
        
              userinfo.userID               = responseObject[@"userid"];
              userinfo.userEmail            = szEmail;
              userinfo.credit               = @"0";
              userinfo.notificationOption   = @"";
              userinfo.categoryOption       = nil;  // this can be all the categories
              
              [self serializeUserInfoObject:userinfo];
              
              if(completion)
                  completion(userinfo);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Login error: %@", error);
              [self alertStatus:@"Invalid username or password." :@"Sign in Failed!": 0];
              if(completion)
                  completion(userinfo);
          }];
}




// Set UIColor from Hex string
//  return UIColor
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:1.0];
}


// Static method on alert
+ (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}



// Get URL
//  get website url
+(NSString*)getWebSiteURL{
    return [NSString stringWithFormat:@"%@%@", szURLMain, szURLForgotPassword];
}
//  get registration url
+(NSString*)getRegistrationURL{
    return [NSString stringWithFormat:@"%@%@", szURLMain, szURLRegistration];
}
//  get forgot password url
+(NSString*)getForgetPasswordURL{
    return [NSString stringWithFormat:@"%@%@", szURLMain, szURLForgotPassword];
}


// Get stored Seeds
// Notice: foreach of the element, must use (SeedModel*) to do a cast
//  return a NSArray
+ (NSArray*)getStoredSeeds {
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    return [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:szKeySeedsArray]];
}

// Set stored Seeds
//  Put an array of Seeds into local storation, which will replace the original one
+(void)setStoredSeeds:(NSArray*)arySeeds {
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    NSData *seralizedData =[NSKeyedArchiver archivedDataWithRootObject:arySeeds];
    [userDefaults setObject:seralizedData forKey:szKeySeedsArray];
    [userDefaults synchronize];
}

// Add one Seed to the Store
//  Add one Seed into the store array
+(void)AddStoredSeed:(SeedModel*)SingleSeed {
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    NSArray* aryStored= [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:szKeySeedsArray]];
    NSMutableArray* aryNewStored= [[NSMutableArray alloc]initWithArray:aryStored];
    [aryNewStored addObject:SingleSeed];
    NSData *seralizedData =[NSKeyedArchiver archivedDataWithRootObject:aryNewStored];
    [userDefaults setObject:seralizedData forKey:szKeySeedsArray];
    [userDefaults synchronize];
}




// deSerialize User Data
+ (UserInfo*) deSerializeUserInfo {
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    return (UserInfo*)[NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:szKeyUserInfo]];
}


// Serialize UserInfo Object
+ (void) serializeUserInfoObject: (UserInfo*)userInfo {
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    NSData *serialziedData= [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [userDefaults setObject:serialziedData forKey:szKeyUserInfo];
}

// Serialize User Data
+ (void) serializeUserInfo: (NSString*)userID
             withUserEmail: (NSString*)userEmail
                withCredit: (NSString*)credit
          withNotification: (NSString*)notification
              withCategory: (NSArray*)category{
    
    UserInfo *userInfo          = [[UserInfo alloc] init];
    userInfo.userID             = userID;
    userInfo.userEmail          = userEmail;
    userInfo.credit             = credit;
    userInfo.notificationOption = notification;
    userInfo.categoryOption     = category;
    
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    NSData *serialziedData= [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [userDefaults setObject:serialziedData forKey:szKeyUserInfo];
}



@end
















































