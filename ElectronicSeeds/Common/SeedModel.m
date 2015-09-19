//
//  SenderAddress.m
//  Shew_v4
//
//  Created by Ben Liu on 26/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import "SenderAddress.h"

@implementation Seed


#pragma mark Serialisation


#define stationIDKey        @"stationID"
#define stationNameKey      @"stationName"
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
    [encoder encodeObject:self.stationID        forKey:stationIDKey];
    [encoder encodeObject:self.stationName      forKey:stationNameKey];
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
    
    self.stationID      = [decoder decodeObjectForKey:stationIDKey];
    self.stationName    = [decoder decodeObjectForKey:stationNameKey];
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


- (BOOL) isEqual:(Seed*)object{
    if([self.stationID isEqualToString:object.stationID])
        return YES;
    else
        return NO;
}

@end
