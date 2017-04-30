//
//  RegisterViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)didTapRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTxt;
@property (weak, nonatomic) IBOutlet UITextField *secondaryTxt;
@property (weak, nonatomic) IBOutlet UITextField *disabilitiesTxt;
@property (weak, nonatomic) IBOutlet UITextField *addressTxt;
- (IBAction)didTapConfirm:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end
