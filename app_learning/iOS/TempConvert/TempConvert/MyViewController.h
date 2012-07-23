//
//  MyViewController.h
//  TempConvert
//
//  Created by xiao lihao on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@interface MyViewController : UIViewController
@property (strong, nonatomic) DetailViewController *detailViewController;

-(IBAction)click:(id)sender;
@end
