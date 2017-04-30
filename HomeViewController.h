//
//  HomeViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HomeViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *chanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *staySafeLabel;
@property (strong, nonatomic) CLLocationManager *theLocManager;
@property (weak, nonatomic) IBOutlet UILabel *theStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
- (IBAction)didTapReport:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@end
