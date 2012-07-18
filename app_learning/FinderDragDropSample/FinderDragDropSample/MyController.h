//
//  MyController.h
//  FinderDragDropSample
//
//  Created by xiao lihao on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyController : NSObject{
    NSMutableArray *file_names;
    IBOutlet NSArrayController *array_controller;
}

@end
