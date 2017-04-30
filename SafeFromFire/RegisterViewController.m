//
//  RegisterViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"

@interface RegisterViewController () <UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.confirmButton.layer setCornerRadius:15];
    self.disabilitiesTxt.delegate=self;
    self.ageTxt.delegate=self;
    self.nameTextField.delegate=self;
    self.addressTxt.delegate=self;
    self.secondaryTxt.delegate=self;
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapRegister:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapConfirm:(id)sender {
    User *anUser = [User new];
    anUser.phoneNo = self.phoneNumberTextField.text;
    if(self.nameTextField.text.length>0){
        anUser.name = self.nameTextField.text;
        anUser.disabilities = self.disabilitiesTxt.text;
        anUser.age = self.ageTxt.text;
        anUser.address = self.addressTxt.text;
        anUser.secondaryAddress=self.secondaryTxt.text;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:anUser];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"loggedUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"goToHome" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
