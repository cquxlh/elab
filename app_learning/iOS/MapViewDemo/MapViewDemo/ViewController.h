//
//  ViewController.h
//  MapViewDemo
//
//  Created by xiao lihao on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
    MKMapView *map;
    CLLocationManager *locationManager;
}

@end
