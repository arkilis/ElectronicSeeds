//
//  SelectItemViewController.m
//
//  Created by Ben Liu on 22/01/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "SelectItemViewController.h"
#import "Common.h"

@interface SelectItemViewController ()

@end

@implementation SelectItemViewController{
    NSString *global_dropbox_url;
}


@synthesize selectedSeed;


//- (void)viewDidLoad {
-(void) viewDidAppear:(BOOL)animated{
    
    //[super viewDidLoad];
    [super viewDidAppear:animated];
    
    
    UIView *sv= self.view;
    
    // Scroll view and container
    UIScrollView *scrollview= [UIScrollView new];
    [sv addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    // create container
    UIView *container= [UIView new];
    [scrollview addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollview);
        make.width.equalTo(scrollview);
    }];
    
    
    // Add map view
    
    GMSMapView *mapView= [GMSMapView new];
    // Add google map and its marker
    mapView.camera = [GMSCameraPosition cameraWithLatitude: [selectedSeed.latitude doubleValue]
                                                 longitude: [selectedSeed.longitude doubleValue]
                                                      zoom: iGoogleMapZoomIn];
    
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([selectedSeed.latitude doubleValue],
                                                 [selectedSeed.longitude doubleValue]);
    
    //marker.snippet = @"Australia";
    marker.map = mapView;
    [container addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_top).with.offset(88);
        make.left.equalTo(container.mas_left);
        make.right.equalTo(container.mas_right);
        NSNumber *height= [NSNumber numberWithDouble:((sv.frame.size.width-10)/4*3.0)];
        make.height.equalTo(height);
    }];
    
    
    // Add Seed name label
    UILabel *seedNameLabelName= [UILabel new];
    [seedNameLabelName setText:@"Seed Name:"];
    [seedNameLabelName setFont:[UIFont boldSystemFontOfSize:16]];
    //[seedNameLabelName showPlaceHolderWithLineColor:[UIColor whiteColor] backColor:[UIColor blackColor] arrowSize:25 lineWidth:3 frameWidth:5 frameColor:[UIColor redColor]];
    [container addSubview:seedNameLabelName];
    [seedNameLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mapView.mas_bottom).with.offset(10);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    UILabel *seedNameLabelValue= [UILabel new];
    [seedNameLabelValue setText:selectedSeed.seedName];
    [container addSubview:seedNameLabelValue];
    [seedNameLabelValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seedNameLabelName.mas_bottom);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    // Add Post date time label
    UILabel *postDatetimeLabelName= [UILabel new];
    [postDatetimeLabelName setText:@"Post Date & Time:"];
    [postDatetimeLabelName setFont:[UIFont boldSystemFontOfSize:16]];
    [container addSubview:postDatetimeLabelName];
    [postDatetimeLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seedNameLabelValue.mas_bottom).with.offset(10);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    UILabel *postDatetimeLabelValue= [UILabel new];
    [postDatetimeLabelValue setText:selectedSeed.postDateTime];
    [container addSubview:postDatetimeLabelValue];
    [postDatetimeLabelValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(postDatetimeLabelName.mas_bottom);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    // Add Expire date time label
    UILabel *expireDatetimeLabelName= [UILabel new];
    [expireDatetimeLabelName setText:@"Expire Date & Time:"];
    [expireDatetimeLabelName setFont:[UIFont boldSystemFontOfSize:16]];
    [container addSubview:expireDatetimeLabelName];
    [expireDatetimeLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(postDatetimeLabelValue.mas_bottom).with.offset(10);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    UILabel *expireDatetimeLabelValue= [UILabel new];
    [container addSubview:expireDatetimeLabelValue];
    [expireDatetimeLabelValue setText:selectedSeed.expireDateTime];
    [expireDatetimeLabelValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expireDatetimeLabelName.mas_bottom);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    // Add distance label
    UILabel *distanceLabelName= [UILabel new];
    [distanceLabelName setText:@"Distance:"];
    [distanceLabelName setFont:[UIFont boldSystemFontOfSize:16]];
    [container addSubview:distanceLabelName];
    [distanceLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expireDatetimeLabelValue.mas_bottom).with.offset(10);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    UILabel *distanceLabelValue= [UILabel new];
    [distanceLabelValue setText: [NSString stringWithFormat:@"%.2f Meters", [selectedSeed.range floatValue]]];
    [container addSubview:distanceLabelValue];
    [distanceLabelValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(distanceLabelName.mas_bottom);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    // Add Decription label
    UILabel *descriptionLabelName= [UILabel new];
    [descriptionLabelName setText:@"Description:"];
    [descriptionLabelName setFont:[UIFont boldSystemFontOfSize:16]];
    [container addSubview:descriptionLabelName];
    [descriptionLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(distanceLabelValue.mas_bottom).with.offset(10);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    // Add Image
    UIImageView *imageView= [UIImageView new];
    NSString *szURLUpload=  [NSString stringWithFormat:@"%@%@", szURLMain, selectedSeed.fileURLUpload];
    [imageView sd_setImageWithURL:[NSURL URLWithString:szURLUpload] placeholderImage:[UIImage imageNamed:@"loading"]];
    imageView.contentMode= UIViewContentModeScaleAspectFit;
    
    [container addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descriptionLabelName.mas_bottom).with.offset(10);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@200);
    }];
    
    UIView *lastview= imageView;
    // Add Dropbox button
    if(![selectedSeed.fileURLDropbox isEqualToString:@""]){
        UIButton *dropboxBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        dropboxBtn.backgroundColor= [Common colorFromHexString:@"#0581E4"];
        dropboxBtn.layer.cornerRadius = 4;
        dropboxBtn.clipsToBounds = YES;
        [dropboxBtn addTarget:self
                       action:@selector(dropboxMethod)
             forControlEvents:UIControlEventTouchUpInside];
        [dropboxBtn setTitle:@"Dropbox Link" forState:UIControlStateNormal];
        [dropboxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [container addSubview:dropboxBtn];
        [dropboxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).with.offset(20);
            make.left.equalTo(mapView.mas_left);
            make.right.equalTo(mapView.mas_right);
            make.height.equalTo(@44);
        }];
        lastview= dropboxBtn;
    }
    
    // Add Apply button
    UIButton *applyBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    applyBtn.backgroundColor= [Common colorFromHexString:@"#0581E4"];
    applyBtn.layer.cornerRadius = 4;
    applyBtn.clipsToBounds = YES;
    [applyBtn addTarget:self
                 action:@selector(applyMethod)
       forControlEvents:UIControlEventTouchUpInside];
    [applyBtn setTitle:@"Apply" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [container addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastview.mas_bottom).with.offset(10);
        make.left.equalTo(mapView.mas_left);
        make.right.equalTo(mapView.mas_right);
        make.height.equalTo(@44);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(applyBtn.mas_bottom).with.offset(88);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dropboxMethod {
    if(![selectedSeed.fileURLUpload isEqualToString:@""]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: global_dropbox_url]];
    }
}


-(void)applyMethod {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:@"You have successfully applied!"];
}


@end




























