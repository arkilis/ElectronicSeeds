//
//  Seed.m
//  Shew_v4
//
//  Created by Ben Liu on 26/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import "SeedModel.h"

@implementation SeedModel


#pragma mark Serialisation


#define seedIDKey           @"seedID"
#define seedNameKey         @"seedName"
#define durationKey         @"duration"
#define longitudeKey        @"longitude"
#define latitudeKey         @"latitude"
#define fileURLUploadKey    @"fileURLUpload"
#define fileURLDropboxKey   @"fileURLDropbox"
#define rangeKey            @"range"
#define postDateTimeKey     @"postDateTime"
#define expireDateTimeKey   @"expireDateTime"
#define addressKey          @"address"
#define categoryKey         @"category"
#define importanceKey       @"importance"


- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.seedID           forKey:seedIDKey];
    [encoder encodeObject:self.seedName         forKey:seedNameKey];
    [encoder encodeObject:self.duration         forKey:durationKey];
    [encoder encodeObject:self.longitude        forKey:longitudeKey];
    [encoder encodeObject:self.latitude         forKey:latitudeKey];
    [encoder encodeObject:self.fileURLUpload    forKey:fileURLUploadKey];
    [encoder encodeObject:self.fileURLDropbox   forKey:fileURLDropboxKey];
    [encoder encodeObject:self.range            forKey:rangeKey];
    [encoder encodeObject:self.postDateTime     forKey:postDateTimeKey];
    [encoder encodeObject:self.expireDateTime   forKey:expireDateTimeKey];
    [encoder encodeObject:self.address          forKey:addressKey];
    [encoder encodeObject:self.category         forKey:categoryKey];
    [encoder encodeObject:self.importance       forKey:importanceKey];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    
    self.seedID         = [decoder decodeObjectForKey:seedIDKey];
    self.seedName       = [decoder decodeObjectForKey:seedNameKey];
    self.duration       = [decoder decodeObjectForKey:durationKey];
    self.longitude      = [decoder decodeObjectForKey:longitudeKey];
    self.latitude       = [decoder decodeObjectForKey:latitudeKey];
    self.fileURLUpload  = [decoder decodeObjectForKey:fileURLUploadKey];
    self.fileURLDropbox = [decoder decodeObjectForKey:fileURLDropboxKey];
    self.range          = [decoder decodeObjectForKey:rangeKey];
    self.postDateTime   = [decoder decodeObjectForKey:postDateTimeKey];
    self.expireDateTime = [decoder decodeObjectForKey:expireDateTimeKey];
    self.address        = [decoder decodeObjectForKey:addressKey];
    self.category       = [decoder decodeObjectForKey:categoryKey];
    self.importance     = [decoder decodeObjectForKey:importanceKey];

    return self;
}


- (BOOL) isEqual:(SeedModel*)object{
    if([self.seedID isEqualToString:object.seedID])
        return YES;
    else
        return NO;
}

@end
