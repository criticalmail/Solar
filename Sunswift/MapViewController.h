//
//  MapViewController.h
//  Sunswift
//
//  Created by Frank Qian on 14/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>{
    IBOutlet MKMapView *mapView;
    MyAnnotation *annotation;
    NSTimer *timer;
    //NSString *strloc;
    //CLGeocoder *geocoder;
}
- (void)updateLocation;
- (void)setStartLocation;
- (IBAction)btnClick:(id)sender;
@property (nonatomic, strong) MKMapView *mapView;

@end
