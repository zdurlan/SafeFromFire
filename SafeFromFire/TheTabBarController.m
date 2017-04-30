//
//  TheTabBarController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "TheTabBarController.h"

@interface TheTabBarController ()

@end

@implementation TheTabBarController{
    BOOL isAble;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theLocManager = [[CLLocationManager alloc] init];
    self.theLocManager.delegate = self;
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAble:) name:@"ableToMove" object:nil];
   
    // Do any additional setup after loading the view.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *loc = locations.lastObject;
    CGFloat lat = 44.42774;
    CGFloat lng = 26.10417;
    CLLocation *mapPoint = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    if(isAble){
        NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",loc.coordinate.latitude, loc.coordinate.longitude, mapPoint.coordinate.latitude, mapPoint.coordinate.longitude];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: directionsURL]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Keep calm, help is on the way." delegate:self cancelButtonTitle:@"Wow much help" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)didReceiveAble:(NSNotification*)notification{
     [self.theLocManager startUpdatingLocation];
    NSDictionary *dict = notification.userInfo;
    NSNumber *isAbleToMove = dict[@"ableToMove"];
    if([isAbleToMove integerValue]==1)
        isAble=YES;
    else
        isAble=NO;
    
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

@end
