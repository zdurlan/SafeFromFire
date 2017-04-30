//
//  MyAnnotation.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>
@property (assign, nonatomic) CLLocationCoordinate2D coord;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
@property (strong, nonatomic) NSString *theTitle;
@end
