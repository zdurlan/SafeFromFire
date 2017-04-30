//
//  MapViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *theLocManager;

@property (weak, nonatomic) IBOutlet MKMapView *theMapView;
@property (weak, nonatomic) IBOutlet UILabel *youAreOk;
@property (strong, nonatomic) MKUserLocation *myLocation;
- (IBAction)didTapReport:(id)sender;
@end
