//
//  CustomLogoutBtnCell.m
//  CustomButtonExample
//
//  Created by Nick Lockwood on 07/04/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "CustomLogoutBtnCell.h"


@interface CustomLogoutBtnCell ()

@property (nonatomic, strong) IBOutlet UIButton *cellButton;

@end


@implementation CustomLogoutBtnCell

//note: we could override -awakeFromNib or -initWithCoder: if we wanted
//to do any customisation in code, but in this case we don't need to

//if we were creating the cell programamtically instead of using a nib
//we would override -initWithStyle:reuseIdentifier: to do the configuration

- (IBAction)buttonAction
{
    if (self.field.action) self.field.action(self);
}

@end
