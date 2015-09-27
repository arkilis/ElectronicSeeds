//
//  MeFXForm.h
//  Gremlins
//
//  Created by Ben Liu on 26/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"
#import "Common.h"
#import "UserInfo.h"
#import "CustomLogoutBtnCell.h"

@interface MeFXForm : NSObject  <FXForm>

@property (nonatomic, copy)     NSString    *account;
@property (nonatomic, copy)     NSString    *setting;
@property (nonatomic, copy)     NSArray     *category;
@property (nonatomic, strong)   id          facebook;
@property (nonatomic, strong)   id          twitter;
@property (nonatomic, strong)   id          about;
@property (nonatomic, strong)   id          btnLogout;

@end
