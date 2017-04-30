//
//  ProfileViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ProfileViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *personalinfo;
@property (strong, nonatomic) CLLocationManager *theLocManager;
@property (strong, nonatomic) CLLocation *theLocation;
@property (weak, nonatomic) IBOutlet UITextField *secondAddress;
@property (weak, nonatomic) IBOutlet UITextField *firstAddress;
- (IBAction)didTapSave:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *theStatusLabel;
- (IBAction)didTapCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *checkedImage;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)didTapReport:(id)sender;

@end
