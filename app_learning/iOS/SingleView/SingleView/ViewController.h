//
//  ViewController.h
//  SingleView
//
//  Created by xiao lihao on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UISlider* slider;
    IBOutlet UILabel* label;
}

-(IBAction)changeSlider:(id)sender;
@end
