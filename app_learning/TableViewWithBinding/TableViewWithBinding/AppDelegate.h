//
//  AppDelegate.h
//  TableViewWithBinding
//
//  Created by xiao lihao on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField* idField;

/*bind to appdelegate with model key path:nameText*/
@property (assign) IBOutlet NSTextField* nameField;


/*new a array controller, drag it from object lib to xib main window*/
/*add binding to appdelegate with model key path:datasource*/
/*first colum value binds to array controller with model key path:id*/
/*second colum value binds to array controller with model key path:name*/
@property (retain)NSMutableArray* datasource;
@property (retain)NSString* idText;
@property (retain)NSString* nameText;

-(IBAction)addItem2Table:(id)sender;
@end

/* add right mouse event to view
 
 -(void) rightMouseDown:(NSEvent *)theEvent{
 row = [self selectedRow];
 }
 
 -(void) rightMouseUp:(NSEvent *)theEvent{ 
 NSMenu *men = [[NSMenu alloc] init];
 NSMenuItem *menitem = [[NSMenuItem alloc] init];
 menitem.title = @"delete";
 menitem.target = nil;//use msg chain
 menitem.action=@selector(deleteItem);
 
 [menitem setEnabled:YES];
 [men addItem:menitem];
 
 [NSMenu popUpContextMenu:men withEvent:theEvent forView:self];
 
 [men update];
 }
 */