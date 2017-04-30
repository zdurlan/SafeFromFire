//
//  TheTabBarController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import <MapKit/MapKit.h>

@interface TheTabBarController : UITabBarController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *theLocManager;
@end
