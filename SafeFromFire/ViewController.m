//
//  ViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"loggedUser"];
    User *loggedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(loggedUser){
        [self performSegueWithIdentifier:@"goToHome" sender:self];
    }
    [self.registerButton.layer setCornerRadius:15];
    [self.registerButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.registerButton.layer setBorderWidth:1];
    [self.skipButton.layer setCornerRadius:15];
    [self.skipButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.skipButton.layer setBorderWidth:1];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapSkip:(id)sender {
    [self performSegueWithIdentifier:@"goToHome" sender:self];
}

- (IBAction)didTapRegister:(id)sender {
    [self performSegueWithIdentifier:@"goToRegister" sender:self];
}
@end
