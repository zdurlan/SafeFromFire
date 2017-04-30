//
//  PanicViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "PanicViewController.h"
#import "User.h"

@interface PanicViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@end

@implementation PanicViewController{
    BOOL isAbleToMove;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.otherAddressTxt.delegate=self;
    self.nameTxt.delegate=self;
    self.phoneNoTxt.delegate=self;
    self.manyPeopleTxt.delegate=self;
    self.whatIsBurningTxt.delegate=self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"loggedUser"];
    User *loggedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.nameTxt.text = loggedUser.name;
    self.phoneNoTxt.text = loggedUser.phoneNo;
    self.mainAddressLabel.text = loggedUser.address;
    self.secondAddressLabel.text = loggedUser.secondaryAddress;
    [self.saveButton.layer setCornerRadius:15];
    [self.takePhotoButton.layer setCornerRadius:15];
    [self.takePhotoButton.layer setBorderColor:[UIColor blueColor].CGColor];
    [self.takePhotoButton.layer setBorderWidth:1];
    // Do any additional setup after loading the view.
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

- (IBAction)didTapSave:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithBool:isAbleToMove] forKey:@"ableToMove"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ableToMove" object:nil userInfo:dict];
    
}

- (IBAction)didTapTakePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    picker.showsCameraControls = YES;
    [self presentViewController:picker animated:YES
                     completion:^ {
                         
                     }];
}
- (IBAction)didSelectAddressSegment:(id)sender {
    if (self.userAddressSegment.selectedSegmentIndex == 0) {
        self.mainAddressSwitch.hidden=NO;
        self.secondAddressSwitch.hidden=NO;
        self.secondAddressLabel.hidden=NO;
        self.mainAddressLabel.hidden=NO;
        self.otherAddressTxt.hidden=YES;
    } else if(self.userAddressSegment.selectedSegmentIndex == 1) {
        self.mainAddressSwitch.hidden=YES;
        self.mainAddressLabel.hidden=YES;
        self.secondAddressSwitch.hidden=YES;
        self.secondAddressLabel.hidden=YES;
        self.otherAddressTxt.hidden=NO;
    }
}
- (IBAction)didSelectMainAddress:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        [self.secondAddressSwitch setOn:YES];
    }else{
        [mySwitch setOn:YES];
        [self.secondAddressSwitch setOn:NO];
    }
}
- (IBAction)didSelectSecondAddress:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        [self.mainAddressSwitch setOn:YES];
    }else{
        [mySwitch setOn:YES];
        [self.mainAddressSwitch setOn:NO];
    }
}
- (IBAction)didSelectZero:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        [self.oneTooManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
    }else{
        [mySwitch setOn:YES];
        [self.oneTooManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
    }
}
- (IBAction)didSelectOne:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        [self.zeroManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
    }else{
        [mySwitch setOn:YES];
        [self.zeroManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
    }
}
- (IBAction)didSelectTwo:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        [self.oneTooManyPeople setOn:NO];
        [self.zeroManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
    }else{
        [mySwitch setOn:YES];
        [self.oneTooManyPeople setOn:NO];
        [self.zeroManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
    }
}
- (IBAction)didSelectThree:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        [self.oneTooManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.zeroManyPeople setOn:NO];
    }else{
        [mySwitch setOn:YES];
        [self.oneTooManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.zeroManyPeople setOn:NO];
    }
}
- (IBAction)didSelectAbleToMove:(id)sender {
    if (self.userAddressSegment.selectedSegmentIndex == 0) {
        isAbleToMove=YES;
    } else if(self.userAddressSegment.selectedSegmentIndex == 1) {
        isAbleToMove=NO;
    }

}

- (IBAction)didSelectMore:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        [self.oneTooManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.zeroManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
        self.whatIsBurningTxt.hidden=YES;
    }else{
        [mySwitch setOn:YES];
        [self.oneTooManyPeople setOn:NO];
        [self.Two2ManyPeople setOn:NO];
        [self.zeroManyPeople setOn:NO];
        [self.threeTooManyPeople setOn:NO];
        self.whatIsBurningTxt.hidden=NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)didSwitchOther:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        [mySwitch setOn:NO];
        self.manyPeopleTxt.hidden=YES;
    }else{
        [mySwitch setOn:YES];
        self.manyPeopleTxt.hidden=NO;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.theImageView setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
