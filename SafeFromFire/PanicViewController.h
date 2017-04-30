//
//  PanicViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PanicViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *otherAddressTxt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *userAddressSegment;
@property (weak, nonatomic) IBOutlet UITextField *phoneNoTxt;
@property (weak, nonatomic) IBOutlet UISwitch *mainAddressSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *secondAddressSwitch;
@property (weak, nonatomic) IBOutlet UILabel *secondAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainAddressLabel;
@property (weak, nonatomic) IBOutlet UISwitch *officeTower;
@property (weak, nonatomic) IBOutlet UISwitch *other;
@property (weak, nonatomic) IBOutlet UISwitch *groundFloor;
@property (weak, nonatomic) IBOutlet UISwitch *apartment;
@property (weak, nonatomic) IBOutlet UISwitch *farm;
@property (weak, nonatomic) IBOutlet UISwitch *forest;
@property (weak, nonatomic) IBOutlet UISwitch *entireBuilding;
@property (weak, nonatomic) IBOutlet UITextField *whatIsBurningTxt;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)didTapSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
- (IBAction)didTapTakePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *zeroManyPeople;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ableToMove;
@property (weak, nonatomic) IBOutlet UISwitch *threeTooManyPeople;
@property (weak, nonatomic) IBOutlet UISwitch *oneTooManyPeople;
@property (weak, nonatomic) IBOutlet UITextField *manyPeopleTxt;
@property (weak, nonatomic) IBOutlet UISwitch *moreManyPeople;
@property (weak, nonatomic) IBOutlet UISwitch *Two2ManyPeople;

@end
