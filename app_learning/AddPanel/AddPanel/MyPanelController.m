//
//  MyPanelController.m
//  AddPanel
//
//  Created by xiao lihao on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyPanelController.h"

@implementation MyPanelController

-(IBAction)sendNotification:(id)sender{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    NSDictionary *d = [NSDictionary dictionaryWithObject:@"hello" forKey:@"world"];
    [nc postNotificationName:@"testNotification" object:self userInfo:d];
}

-(id)init{
    if(![super initWithWindowNibName:@"MyPanel"])
        return nil;
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
