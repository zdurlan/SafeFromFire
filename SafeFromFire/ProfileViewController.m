//
//  ProfileViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//
#import "User.h"
#import "ProfileViewController.h"

@interface ProfileViewController ()
{
    UIImage *checkedImage;
    UIImage *uncheckedImage;
    BOOL isFirefighter;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theLocManager = [[CLLocationManager alloc] init];
    self.theLocManager.delegate=self;
    self.theLocation = [[CLLocation alloc] init];
    uncheckedImage = [[UIImage alloc] init];
    checkedImage = [UIImage imageNamed:@"checked"];
    uncheckedImage = [UIImage imageNamed:@"check"];
    [self.saveButton.layer setCornerRadius:15];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"loggedUser"];
    User *loggedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(loggedUser){
        self.firstAddress.text = loggedUser.name;
        self.secondAddress.text = loggedUser.address;
        self.personalinfo.text = loggedUser.disabilities;
    }else{
        self.firstAddress.hidden=YES;
        self.secondAddress.hidden=YES;
        self.personalinfo.hidden=YES;
        self.saveButton.hidden=YES;
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
     [self.theLocManager startUpdatingLocation];
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

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.theLocation = locations.lastObject;
}

- (IBAction)didTapSave:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"loggedUser"];
    User *loggedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    loggedUser.name = self.firstAddress.text;
    loggedUser.address = self.secondAddress.text;
    loggedUser.disabilities = self.personalinfo.text;
    loggedUser.isFirefighter = [NSNumber numberWithBool:isFirefighter];
    NSData *datax = [NSKeyedArchiver archivedDataWithRootObject:loggedUser];
    [[NSUserDefaults standardUserDefaults] setObject:datax forKey:@"loggedUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([UIImagePNGRepresentation(self.checkedImage.image) isEqualToData:UIImagePNGRepresentation(checkedImage)]){
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:44.4388984 longitude:26.057735800000046];
        NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",loc.coordinate.latitude, loc.coordinate.longitude, self.theLocation.coordinate.latitude, self.theLocation.coordinate.longitude];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: directionsURL]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Changes saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self.view endEditing:YES];
    
}
- (IBAction)didTapCheck:(id)sender {
    if ([UIImagePNGRepresentation(self.checkedImage.image) isEqualToData:UIImagePNGRepresentation(uncheckedImage)]){
        self.checkedImage.image = [UIImage imageNamed:@"checked"];
        isFirefighter=YES;
    }else{
        self.checkedImage.image = [UIImage imageNamed:@"check"];
        isFirefighter=NO;
    }
}

- (IBAction)didTapReport:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"loggedUser"];
    User *loggedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(loggedUser){
        [self performSegueWithIdentifier:@"goToPanic" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You must be logged in to use this feature" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
}
@end
