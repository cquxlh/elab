//
//  AppDelegate.h
//  MyTagView
//
//  Created by xiao lihao on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TagView;
@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (strong) IBOutlet TagView *tagView;
@property (strong) IBOutlet NSScrollView *scrollView;
- (IBAction)AddTag:(id)sender;
@property (strong) IBOutlet NSTextView *textView;
- (void)AddTagWithText:(NSString*)text;
@property (assign) IBOutlet NSWindow *window;
- (CGImageRef)nsImageToCGImageRef:(NSImage*)image;

@end
