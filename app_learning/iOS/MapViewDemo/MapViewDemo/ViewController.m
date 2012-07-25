//
//  ViewController.m
//  MapViewDemo
//
//  Created by xiao lihao on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {  
    [locationManager stopUpdatingLocation];  
    
    NSString *strLat = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.latitude];  
    NSString *strLng = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.longitude];  
    NSLog(@"Lat: %@  Lng: %@", strLat, strLng);  
    
}  

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {  
    NSLog(@"locError:%@", error);  
    
}  
- (void)viewDidLoad
{
    map = [[MKMapView alloc] initWithFrame:[self.view bounds]];  
    map.showsUserLocation = YES;  
    map.mapType = MKMapTypeStandard;  
    [self.view addSubview:map];
    
    locationManager = [[CLLocationManager alloc] init];  
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
