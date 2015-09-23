//
//  Seed.h
//  Class of Station/Seeds/Ads
//
//  Created by Ben Liu on 26/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SeedModel : NSObject

// Properties
@property (nonatomic, strong) NSString *seedID;
@property (nonatomic, strong) NSString *seedName;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *fileURLUpload;
@property (nonatomic, strong) NSString *fileURLDropbox;
@property (nonatomic, strong) NSString *range;          // Range is the m
@property (nonatomic, strong) NSString *postDateTime;
@property (nonatomic, strong) NSString *expireDateTime;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *importance;


// Methods
- (BOOL) isEqual:(SeedModel*)object;

@end
