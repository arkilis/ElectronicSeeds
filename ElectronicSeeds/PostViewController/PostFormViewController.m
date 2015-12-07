//
//  PostFormViewController.m
//
//

#import "PostFormViewController.h"
#import "PostForm.h"


@interface PostFormViewController(){
    NSMutableDictionary *dictCategory;
    NSMutableDictionary *dictDuration;
}
@end


@implementation PostFormViewController

@synthesize szAddr;

// init values for Category dictionary
-(void)initWithCategoryDict{
    dictCategory = [NSMutableDictionary dictionaryWithDictionary: @{
                                                                    @"Freebie"          : @"1",
                                                                    @"Discount"         : @"2",
                                                                    @"Drink"            : @"3",
                                                                    @"Entertainment"    : @"4",
                                                                    @"Travel"           : @"5",
                                                                    @"Sports"           : @"6",
                                                                    @"Accommondation"   : @"7",
                                                                    @"Attraction"       : @"8",
                                                                    @"Meal"             : @"9",
                                                                    @"Movie"            : @"10"
                                                                    
                                                                    }];
}

// init values for Duration dictionary
-(void)initWithDuration{
    dictDuration= [NSMutableDictionary dictionaryWithDictionary: @{
                                                                  @"15 Mins"    : @"15",
                                                                  @"30 Mins"    : @"30",
                                                                  @"1 Hour"     : @"60",
                                                                  @"2 Hours"    : @"120",
                                                                  @"3 Hours"    : @"180",
                                                                  @"4 Hours"    : @"240",
                                                                  @"5 Hours"    : @"300",
                                                                  @"10 Hours"   : @"600",
                                                                  @"1 Day"      : @"1440",
                                                                  @"2 Days"     : @"2880",
                                                                  @"Unlimited"  : @"-1"
                                                                  }];

}


- (void)awakeFromNib
{
    //set up form
    self.formController.form = [[PostForm alloc] init];
}

- (void)submitRegistrationForm:(UITableViewCell<FXFormFieldCell> *)cell
{
    PostForm *form = cell.field.form;
    
    // Form Validation & Form submission
    // IMPORTANT
    // FOR SAFTY RESON, I ONLY CAN OPEN SOURCE PART OF THE CODE
    
    __block NSString *szUploadImage;
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Form submission code
        // End of Form submission code
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"Success"];
        });
    });
    
}

// Back to login view
- (IBAction)btnBacktoLogin:(UIBarButtonItem *)sender {
    // Custome animation
    //[self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    LoginViewController  *logVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewControl"];
    [self presentViewController:logVC animated:NO completion:nil];
}


@end









