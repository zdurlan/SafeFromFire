//
//  DetailsViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailsViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *theLocManager;
@property (weak, nonatomic) IBOutlet UILabel *chanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpdLabel;
@property (weak, nonatomic) IBOutlet UILabel *humLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDir;
@property (weak, nonatomic) IBOutlet UILabel *rainLabel;
@end
