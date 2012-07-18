//
//  AppDelegate.m
//  TableViewWithDataSource
//
//  Created by xiao lihao on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

static NSString* defaultId = @"010";
static NSString* defaultName = @"hello world";
@implementation AppDelegate

@synthesize window = _window;
@synthesize view;
@synthesize idField;
@synthesize nameField;
@synthesize datasource;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    datasource = [[NSMutableArray alloc] init];
    
}
- (NSInteger) numberOfRowsInTableView:(NSTableView *)table {
    NSLog(@"call get Number");
    return datasource.count; 
}

- (id) tableView: (NSTableView *)table
        objectValueForTableColumn: (NSTableColumn *)column 
             row: (NSInteger)row{

    NSLog(@"call getObject");
    NSDictionary* line = [datasource objectAtIndex:row]; 
    NSString* identifier = column.identifier;
    
    return [line objectForKey:identifier];
}

- (void) tableView: (NSTableView*)table
    setObjectValue:(id)object 
    forTableColumn:(NSTableColumn *)column 
               row:(NSInteger)row{
    
    NSLog(@"call setObject");
    NSMutableDictionary* line = [datasource objectAtIndex:row]; 
    NSString* identifier = column.identifier;
    
    [line setObject:object forKey:identifier];
}



-(IBAction)addItem2Table:(id)sender{
    
    NSLog(@"add a item");
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    
    /*note:set colum id to 'id' and 'name' in identify inspector*/
    if(![idField.stringValue isEqualToString:@""])
        [dic setObject:idField.stringValue forKey:@"id"];
    else
        [dic setObject:defaultId forKey:@"id"];


    if(![nameField.stringValue isEqualToString:@""])
        [dic setObject:nameField.stringValue forKey:@"name"];
    else
        [dic setObject:defaultName forKey:@"name"];
    
    NSLog(@"%@,%@", idField.stringValue, nameField.stringValue);
    [datasource addObject:dic];
    
    nameField.stringValue = @"";
    idField.stringValue = @"";
    
    [view reloadData];
}

@end
















