//
//  AppController.h
//  Test
//
//  Created by xiao lihao on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@class Person;
@interface AppController : NSDocument{
    IBOutlet NSTextField* textField;
    IBOutlet NSButton* speak;
    IBOutlet NSButton* stop;
    IBOutlet NSTableView* view;
    NSSpeechSynthesizer* speech;
    NSArray* array;
    NSMutableArray* person;
}

-(void)insertObject:(Person*)p inPersonAtIndex:(int)index;
-(IBAction)sayIt:(id)sender;
-(IBAction)stopIt:(id)sender;
@end
