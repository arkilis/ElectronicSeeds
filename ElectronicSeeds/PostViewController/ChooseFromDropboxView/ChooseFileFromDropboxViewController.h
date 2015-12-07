//
//  ChooseFileFromDropboxViewController.h
//  Gremlins
//
//  Created by Ben Liu on 9/04/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DBChooser/DBChooser.h>
#import "Common.h"
#import "FXForms.h"

@interface ChooseFileFromDropboxViewController : UIViewController

@property (nonatomic, strong) FXFormField           *field;
@property (strong, nonatomic) IBOutlet UIButton     *btnChooseFromDropbox;
@property (strong, nonatomic) IBOutlet UILabel      *labelFileName;
@property (strong, nonatomic) IBOutlet UILabel      *labelFileSize;

@end
