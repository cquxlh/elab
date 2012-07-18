//
//  Home.h
//  FlashCards
//
//  Created by xiao lihao on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AppController;
@interface Home : NSViewController{
    AppController* _appController;
}
-(id)initWithNibName:(NSString *)nibNameOrNil 
              bundle:(NSBundle *)nibBundleOrNil 
       appController:(AppController*)appController;

-(IBAction)startQuizAction:(id)sender;
@end
