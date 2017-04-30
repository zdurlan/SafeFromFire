//
//  MapViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"
#import "User.h"

@interface MapViewController () <MKMapViewDelegate>{
    BOOL updated;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theMapView.delegate=self;
    self.theLocManager = [[CLLocationManager alloc] init];
    self.theLocManager.delegate = self;
    self.myLocation = [[MKUserLocation alloc]init];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.theLocManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if(!updated){
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.05;
        span.longitudeDelta = 0.05;
        self.myLocation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        region.span = span;
        MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
        region.center = self.myLocation.coordinate;
        annot.coordinate = self.myLocation.coordinate;
        [self.theMapView setRegion:region animated:YES];
        [self.theLocManager startUpdatingLocation];
        updated=YES;
        
        NSMutableArray *colA = [NSMutableArray array];
        NSError *error;
        NSString *fileString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fire_records" ofType:@"csv"] encoding:NSUTF8StringEncoding error:&error];
        NSMutableArray* rows = [[NSMutableArray alloc] initWithArray:[fileString componentsSeparatedByString:@"\n"]];
        [rows removeObjectAtIndex:0];
        for (NSString *row in rows){            
            NSArray* columns = [row componentsSeparatedByString:@","];
            if(columns.count > 1){
                CLLocationDegrees latitude = [columns[0] floatValue];
                CLLocationDegrees longitude = [columns[1] floatValue];
                NSString *title =columns[5];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setObject:[NSNumber numberWithFloat:latitude] forKey:@"latitude"];
                [dict setObject:[NSNumber numberWithFloat:longitude] forKey:@"longitude"];
                [dict setObject:title forKey:@"title"];
                [colA addObject:dict];
                
            }
        }
        for(NSDictionary *dict in colA){
            MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
            
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([dict[@"latitude"] doubleValue], [dict[@"longitude"] doubleValue]);
            
            
            mapPin.title =  dict[@"title"];;
            mapPin.coordinate = coord;
            

            [self.theMapView addAnnotation:mapPin];
            
        }


    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapViewIn viewForAnnotation:(id <MKAnnotation>)annotation {
    if (mapViewIn != self.theMapView || [annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *reuseId = @"currentloc";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.theMapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        annotationView.animatesDrop = NO;
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5, 5);
    }
    else
    {
        annotationView.annotation = annotation;
    }
    
    //MyAnnotation *mvAnn = (MyAnnotation *)annotation;
    
    return annotationView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
