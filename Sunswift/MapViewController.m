//
//  MapViewController.m
//  Sunswift
//
//  Created by Frank Qian on 14/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"
@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *dele = [[UIApplication sharedApplication] delegate];
    LiveData *liveData = dele.liveData;
    
    [liveData performSelectorInBackground:@selector(updateData) withObject:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [annotation release];
    [mapView release];
    [super dealloc];
}

-(void)btnClick:(id)sender{
    [self setStartLocation];
}
- (void)setStartLocation{
    AppDelegate *dele = [[UIApplication sharedApplication] delegate];
    LiveData *liveData = dele.liveData;
    
    CLLocationCoordinate2D location;
    if(liveData.longitude == 0 && liveData.latitude == 0){
        //set default to UNSW
        location = CLLocationCoordinate2DMake(-33.916869,151.229916);
    }
    else {
        location = CLLocationCoordinate2DMake(liveData.latitude, liveData.longitude);
    }
    NSLog(@"location: %f, %f",location.latitude,location.longitude);
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    MKCoordinateRegion region;
    region.center = location;
    region.span = span;
    [mapView setRegion:region animated:YES];
    
    
}
- (void)updateLocation{
    AppDelegate *dele = [[UIApplication sharedApplication] delegate];
    LiveData *liveData = dele.liveData;
    
    //if the location doesn't change, just update the date not the view
    if(annotation!=nil){
        if(liveData.longitude == annotation.coordinate.longitude && liveData.latitude == annotation.coordinate.latitude){
            [liveData performSelectorInBackground:@selector(updateData) withObject:nil];
            return;
        }
        else if(liveData.longitude == 0 && liveData.latitude == 0){
            [liveData performSelectorInBackground:@selector(updateData) withObject:nil];
            return;
        }
    }
    //show pin
    
    CLLocationCoordinate2D location;
    NSString *annTitle;
    NSString *annSubtitle;
    if (liveData.longitude == 0 && liveData.latitude == 0) {
        location = CLLocationCoordinate2DMake(-33.916869,151.229916);
        annTitle = @"Here's UNSW";
        annSubtitle = @"The race will begin XX days later!!";
    }
    else {
        location = CLLocationCoordinate2DMake(liveData.latitude, liveData.longitude);
        annTitle = @"Here's the Car";
        annSubtitle = @"Sunswift Solar Car";
    }
    if (annotation != nil) {
        
        [self.mapView removeAnnotation:annotation];
        [annotation release];
    }
    annotation = [[MyAnnotation alloc] initWithCoordinates:location title:annTitle subTitle:annSubtitle];
    
    NSLog(@"coordinate: %f,%f",annotation.coordinate.latitude,annotation.coordinate.longitude);
    [mapView addAnnotation:annotation];
    
    
    
    //update data
    [liveData performSelectorInBackground:@selector(updateData) withObject:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self updateLocation];
    [self setStartLocation];

    [mapView removeAnnotation:annotation];
    [mapView addAnnotation:annotation];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateLocation)userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [timer invalidate];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annot{
    
    if ([annot isKindOfClass:[MyAnnotation class]] ==  NO) {
        return nil;
    }
    if ([map isEqual:self.mapView]==NO) {
        return nil;
    }
    
    //MyAnnotation *senderAnnotation = (MyAnnotation *)annot;
    
    NSString *pinReusableIdentifier = @"pin";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
    
    if (annotationView == nil) {
        annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:pinReusableIdentifier] autorelease];
        
    }
    
    annotationView.canShowCallout = YES;
    annotationView.annotation = annot;
    [annotationView setImage:[UIImage imageNamed:@"arrest.png"]];
    
    
    return annotationView;
}


@end
