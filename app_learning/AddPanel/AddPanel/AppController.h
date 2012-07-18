//
//  AppController.h
//  AddPanel
//
//  Created by xiao lihao on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyPanelController;
@interface AppController : NSObject{
    MyPanelController* aReference;
}

-(IBAction)showPanel:(id)sender;
-(void)testNotification:(NSNotification*)no;
@end
