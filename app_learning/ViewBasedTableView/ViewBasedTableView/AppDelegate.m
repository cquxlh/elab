//
//  AppDelegate.m
//  ViewBasedTableView
//
//  Created by xiao lihao on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize _tableContent;
@synthesize _viewBasedTableView;

static NSString *TableData[] = {
    @"NSQuickLookTemplate",
    @"NSBluetoothTemplate",
    @"NSIChatTheaterTemplate",
    @"NSSlideshowTemplate",
    @"NSActionTemplate", 
    @"NSSmartBadgeTemplate",
    @"NSIconViewTemplate",
    @"NSListViewTemplate",
    @"NSColumnViewTemplate",
    @"NSFlowViewTemplate",
    @"NSPathTemplate",
    @"NSInvalidDataFreestandingTemplate",
    @"NSLockLockedTemplate",
    @"NSLockUnlockedTemplate",
    @"NSGoRightTemplate", 
    @"NSGoLeftTemplate", 
    @"NSRightFacingTriangleTemplate",
    @"NSLeftFacingTriangleTemplate",
    @"NSAddTemplate",
    @"NSRemoveTemplate",
    @"NSRevealFreestandingTemplate",
    @"NSFollowLinkFreestandingTemplate",
    @"NSEnterFullScreenTemplate",
    @"NSExitFullScreenTemplate",
    @"NSStopProgressTemplate",
    @"NSStopProgressFreestandingTemplate",
    @"NSRefreshTemplate",
    @"NSRefreshFreestandingTemplate",
    @"NSBonjour",
    @"NSComputer",
    @"NSFolderBurnable",
    @"NSFolderSmart",
    @"NSFolder",
    @"NSNetwork",
    @"NSMobileMe",
    @"NSMultipleDocuments",
    @"NSUserAccounts",
    @"NSPreferencesGeneral",
    @"NSAdvanced",
    @"NSInfo",
    @"NSFontPanel",
    @"NSColorPanel",
    @"NSUser",
    @"NSUserGroup",
    @"NSEveryone",  
    @"NSUserGuest",
    @"NSMenuOnStateTemplate",
    @"NSMenuMixedStateTemplate",
    @"NSApplicationIcon",
    @"NSTrashEmpty",
    @"NSTrashFull",
    @"NSHomeTemplate",
    @"NSBookmarksTemplate",
    @"NSCaution",
    @"NSStatusAvailable",
    @"NSStatusPartiallyAvailable",
    @"NSStatusUnavailable",
    @"NSStatusNone", 
    nil };



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    _tableContent = [NSMutableArray new];
    // Walk each string in the array until we hit the end (nil)
    NSString **data = &TableData[0];
    while (*data != nil) {
        NSString *name = *data;
        NSImage *image = [NSImage imageNamed:name];
        // our model will consist of a dictionary with Name/Image key pairs
        NSDictionary *dictionary = [[[NSDictionary alloc] initWithObjectsAndKeys:name, @"Name", image, @"Image", nil] autorelease];
        [_tableContent addObject:dictionary];
        data++;
    }
    [_viewBasedTableView reloadData];

}


// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_tableContent count];
}

// This method is optional if you use bindings to provide the data
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Group our "model" object, which is a dictionary
    NSDictionary *dictionary = [_tableContent objectAtIndex:row];
    
    // In IB the tableColumn has the identifier set to the same string as the keys in our dictionary
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"MainCell"]) {
        // We pass us as the owner so we can setup target/actions into this main controller object
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        // Then setup properties on the cellView based on the column
        cellView.textField.stringValue = [dictionary objectForKey:@"Name"];
        cellView.imageView.objectValue = [dictionary objectForKey:@"Image"];
        return cellView;
    } else if ([identifier isEqualToString:@"SizeCell"]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        NSImage *image = [dictionary objectForKey:@"Image"];
        NSSize size = image ? [image size] : NSZeroSize;
        NSString *sizeString = [NSString stringWithFormat:@"%.0fx%.0f", size.width, size.height];
        textField.objectValue = sizeString;
        return textField;
    } else {
        NSAssert1(NO, @"Unhandled table column identifier %@", identifier);
    }
    return nil;
}

@end













