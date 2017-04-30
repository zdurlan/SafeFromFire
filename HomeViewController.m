//
//  HomeViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    BOOL update;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theLocManager = [[CLLocationManager alloc] init];
    self.theLocManager.delegate = self;
    if ([self.theLocManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.theLocManager requestWhenInUseAuthorization];
    }
    [self.theLocManager startUpdatingLocation];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *loc = locations.lastObject;
    if(!update) {
        update=YES;
        NSString *stringUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&mode=json&units=metric&cnt=1&appid=a4c6a341be13ea337949e5e6ad2d02f0",loc.coordinate.latitude, loc.coordinate.longitude];
        NSURL *url = [NSURL URLWithString:stringUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 BOOL highTemp=NO;
                 BOOL lowHumidity=NO;
                 BOOL highWind=NO;
                 BOOL cloudy=NO;
                 BOOL lightning=NO;
                 BOOL rainy=NO;
                 NSDictionary *dicYourResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 NSString *theChance = @"LOW";
                 NSArray *list = dicYourResponse[@"list"];
                 NSDictionary *listDict = list.firstObject;
                 NSString *windspeed = listDict[@"speed"];
                 NSString *rain = listDict[@"rain"];
                 NSString *winddirection = listDict[@"deg"];
                 NSString *humidity = listDict[@"humidity"];
                 NSString *cloud = listDict[@"clouds"];
                 NSDictionary *temp = listDict[@"temperature"];
                 NSString *temperature = temp[@"max"];
                 NSString *averageNumber = @"5";
                 NSArray *weather = listDict[@"weather"];
                 NSDictionary *weatherDict = weather.firstObject;
                 NSString *description = weatherDict[@"description"];
                 if([temperature integerValue]>35)
                     highTemp=YES;
                 if([humidity integerValue]<40)
                     lowHumidity=YES;
                 if([windspeed integerValue]>25){
                     highWind=YES;
                 }
                 if([rain integerValue]>10){
                     rainy=YES;
                 }
                 if([cloud integerValue]>40) cloudy=YES;
                 if([description isEqualToString:@"thunderstorm"]) lightning=YES;
                 if(highWind && highTemp && lowHumidity && [averageNumber integerValue]>5){
                     theChance = @"VERY HIGH";
                 }
                 if(highWind && highTemp && lowHumidity)
                     theChance=@"HIGH";
                 if(highWind && lightning && [averageNumber integerValue]>5)
                     theChance=@"VERY HIGH";
                 if(rainy && !highTemp) theChance=@"VERY LOW";
                 if(rainy) theChance=@"LOW";
                 
                 self.chanceLabel.text = theChance;
         
                 
             }
         }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapSeeWhy:(id)sender {
    [self performSegueWithIdentifier:@"goToDetails" sender:self];
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
