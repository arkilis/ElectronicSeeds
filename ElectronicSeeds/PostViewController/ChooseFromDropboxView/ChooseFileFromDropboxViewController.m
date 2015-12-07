//
//  ChooseFileFromDropboxViewController.m
//  Gremlins
//
//  Created by Ben Liu on 9/04/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "ChooseFileFromDropboxViewController.h"

@implementation ChooseFileFromDropboxViewController {
    DBChooserResult *result;            // result received from last CHooser call
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // choose from dropbox button style
    self.btnChooseFromDropbox.backgroundColor = [Common colorFromHexString:@"#1081DE"];
    self.btnChooseFromDropbox.layer.cornerRadius = 5;
    self.btnChooseFromDropbox.clipsToBounds = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnChooseFileFromDropbox:(id)sender {
    
    [[DBChooser defaultChooser] openChooserForLinkType:DBChooserLinkTypeDirect
                                    fromViewController:self 
                                            completion:^(NSArray *results)
    {
        if ([results count]) {
            // Process results from Choose file from dropbox
            result = results[0];
            NSLog(@"Results:%@", result.name);
            NSLog(@"Results:%@", [NSString stringWithFormat: @"%lld Bytes", result.size]);
            NSLog(@"Results:%@", result.link);
                                            
            self.labelFileName.text= result.name;
            self.labelFileSize.text= [NSString stringWithFormat: @"%lld Bytes", result.size];

            
            NSArray *ary_res= @[result.name,result.link];
            self.field.value= ary_res;
                                            
            } else {
                // User canceled the action
                [Common alertStatus:@"You did not select any file" withTitle:@"Invalid File" :0];
            }
    }];
}


@end















