//
//  AppDelegate.h
//  ViewBasedTableView
//
//  Created by xiao lihao on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) NSMutableArray* _tableContent;
@property (assign) IBOutlet NSTableView* _viewBasedTableView;
@end
