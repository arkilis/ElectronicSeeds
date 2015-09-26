//
//  Common.h
//  ElectronicSeeds
//
//  Created by Ben Liu on 19/09/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"
#import "SeedModel.h"
#import "AFNetworking.h"
#import "UserInfo.h"


@interface Common : NSObject



/*
*
*  Class property
*
*/


// Property location Manager
@property (nonatomic,retain) CLLocationManager *locationManager;



/*
*
* Class methods
*
*/

// Get the device location
- (NSString *)deviceLocation;
- (void)getNearbySeedsArray: (NSString*) szLocation
             withCompletion: (void (^)(NSMutableArray* aryRes))completion;

-(void)getFutureSeedsArray: (NSString*)szLocation
            withCompletion:(void (^)(NSMutableArray* aryRes))completion;

/*
*
* Static methods
*
*/

// Set UIColor from Hex string
+ (UIColor *)colorFromHexString:(NSString *)hexString;

// Get Stored Seeds array
+ (NSArray*)getStoredSeeds;
// Store an array of seeds to local storation
+(void)setStoredSeeds:(NSArray*)arySeeds;
// Add a new seed to local storation
+(void)AddStoredSeed:(SeedModel*)SingleSeed;


// Serialize User Data
+ (UserInfo*) deSerializeUserInfo;
+ (void) serializeUserInfo: (NSString*) userID
             withUserEmail: (NSString*) userEmail
                withCredit: (NSString*) credit
          withNotification: (NSString*) notification
              withCategory: (NSArray*)  category;


@end
