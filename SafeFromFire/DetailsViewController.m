//
//  DetailsViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "DetailsViewController.h"
#import <SafariServices/SafariServices.h>

@interface DetailsViewController () <SFSafariViewControllerDelegate>

@end

@implementation DetailsViewController{
    BOOL updated;
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
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
    if(!updated){
        updated=YES;
        NSString *stringUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&mode=json&units=metric&cnt=7&appid=a4c6a341be13ea337949e5e6ad2d02f0",loc.coordinate.latitude, loc.coordinate.longitude];
        NSURL *url = [NSURL URLWithString:stringUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *dicYourResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 BOOL highTemp=NO;
                 BOOL lowHumidity=NO;
                 BOOL highWind=NO;
                 BOOL cloudy=NO;
                 BOOL lightning=NO;
                 BOOL rainy=NO;
                 NSString *theChance = @"LOW";
                 NSArray *list = dicYourResponse[@"list"];
                 NSDictionary *listDict = list.firstObject;
                 NSString *windspeed = listDict[@"speed"];
                 self.windSpdLabel.text = [NSString stringWithFormat:@"%.2f km/h", ([windspeed doubleValue]*18)/5];
                 NSString *rain = listDict[@"rain"];
                 if(rain)
                     self.rainLabel.text = [NSString stringWithFormat:@"%@", rain];
                 else
                     self.rainLabel.text = @"no rain activity";
                 NSString *winddirection = listDict[@"deg"];
                 NSString *theDirection=@"";
                 if([winddirection doubleValue]>=348.75 && [winddirection doubleValue]<11.25){
                     theDirection=@"N";
                 }else if([winddirection doubleValue]>=33.75 && [winddirection doubleValue]<56.25){
                     theDirection=@"NE";
                 }else if([winddirection doubleValue]>=11.25 && [winddirection doubleValue]<33.75){
                     theDirection=@"NNE";
                 }else if([winddirection doubleValue]>=56.25 && [winddirection doubleValue]<78.75){
                     theDirection=@"ENE";
                 }else if([winddirection doubleValue]>=78.75 && [winddirection doubleValue]<101.25){
                     theDirection=@"E";
                 }else if([winddirection doubleValue]>=101.25 && [winddirection doubleValue]<123.75){
                     theDirection=@"ESE";
                 }else if([winddirection doubleValue]>=123.75 && [winddirection doubleValue]<146.25){
                     theDirection=@"SE";
                 }else if([winddirection doubleValue]>=146.25 && [winddirection doubleValue]<168.75){
                     theDirection=@"SSE";
                 }else if([winddirection doubleValue]>=168.75 && [winddirection doubleValue]<191.25){
                     theDirection=@"S";
                 }else if([winddirection doubleValue]>=191.25 && [winddirection doubleValue]<213.75){
                     theDirection=@"SSW";
                 }else if([winddirection doubleValue]>=213.75 && [winddirection doubleValue]<236.25){
                     theDirection=@"SW";
                 }else if([winddirection doubleValue]>=236.25 && [winddirection doubleValue]<258.75){
                     theDirection=@"WSW";
                 }else if([winddirection doubleValue]>=258.75 && [winddirection doubleValue]<281.25){
                     theDirection=@"W";
                 }else if([winddirection doubleValue]>=281.25 && [winddirection doubleValue]<303.75){
                     theDirection=@"WNW";
                 }else if([winddirection doubleValue]>=303.75 && [winddirection doubleValue]<326.25){
                     theDirection=@"NW";
                 }else if([winddirection doubleValue]>=326.25 && [winddirection doubleValue]<348.75){
                         theDirection=@"NNW";
                     }

                 self.windDir.text = [NSString stringWithFormat:@"%@", theDirection];
                 NSString *humidity = listDict[@"humidity"];
                 NSString *cloud = listDict[@"clouds"];
                 self.humLabel.text = [NSString stringWithFormat:@"%@ %%", humidity];
                 NSDictionary *temp = listDict[@"temp"];
                 NSString *temperature = temp[@"max"];
                 self.tempLabel.text = [NSString stringWithFormat:@"%@ C", temperature];
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
- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)seeTheInteractiveMap:(id)sender {
    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://firms.modaps.eosdis.nasa.gov/firemap/"]];
    svc.delegate = self;
    [self presentViewController:svc animated:YES completion:nil];
}

@end
