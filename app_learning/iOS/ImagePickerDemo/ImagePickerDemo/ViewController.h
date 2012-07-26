//
//  ViewController.h
//  ImagePickerDemo
//
//  Created by xiao lihao on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)choosephoto:(id)sender;
- (IBAction)takephoto:(id)sender;

@end
