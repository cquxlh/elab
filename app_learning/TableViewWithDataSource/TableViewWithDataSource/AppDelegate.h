//
//  AppDelegate.h
//  TableViewWithDataSource
//
//  Created by xiao lihao on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

/*outlet is a method to create reference to controll in xib file*/
/*IBOutlet flag let variable can be seen in xib window*/
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField* idField;
@property (assign) IBOutlet NSTextField* nameField;
@property (assign) IBOutlet NSTableView* view;

/*complier will create setter and getter automatically*/
@property (retain) NSMutableArray* datasource;


/*three method need to implemented*/
- (NSInteger) numberOfRowsInTableView:(NSTableView *)table;

- (id) tableView: (NSTableView *)table
        objectValueForTableColumn: (NSTableColumn *)column 
             row: (NSInteger)row;

- (void) tableView: (NSTableView*)table
        setObjectValue:(id)object 
        forTableColumn:(NSTableColumn *)column 
               row:(NSInteger)row;

- (IBAction)addItem2Table:(id)sender;
@end
