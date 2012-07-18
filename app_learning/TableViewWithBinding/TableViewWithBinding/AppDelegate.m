//
//  AppDelegate.m
//  TableViewWithBinding
//
//  Created by xiao lihao on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize idField;
@synthesize nameField;
@synthesize idText;
@synthesize nameText;
@synthesize datasource;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    datasource = [[NSMutableArray alloc] init];
}


- (IBAction)addItem2Table:(id)sender{
    
    if(![idField.stringValue isEqualToString:@""])
        [self setIdText:idField.stringValue];
    else
        [self setIdText:@"default id"];
    
    if(![nameField.stringValue isEqualToString:@""])
        [self setNameText:nameField.stringValue];
    else
        [self setNameText:@"default name"];
    
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:idText forKey:@"id"];
    [dic setObject:nameText forKey:@"name"];
    
    /*If you make changes directly to a mutable array, any views bound to the array will not see the changes. Instead, use the -mutableArrayValueFor Key: method, which returns an array proxy object that is bindings- aware. Any changes to this proxy object will be sent to the bound views.*/
    /*can't call [datasource addObject:dic]*/
    [[self mutableArrayValueForKey:@"datasource"] addObject:dic];
    
    [self setIdText:@""];
    [self setNameText:@""];
  
}
@end











