//
//  MyView.m
//  CustomView
//
//  Created by xiao lihao on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*copy cut paste command will be put in nil-target links*/
/*1. key window:firestResponder and it's link(including super view and key window itself)*/
/*2. key window's delegate*/
/*3. do the some to main window*/
/*4. NSApplication*/
/*5. NSApplication's delegate*/
/*
-(IBAction)copy:(id)sender{
    NSLog(@"copy");
    
    NSPasteboard *pb=[NSPasteboard generalPasteboard];
    [pb declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
    [pb setString:@"A" forType:NSStringPboardType];
}

-(IBAction)cut:(id)sender{
    [self copy:(id)sender];
    NSLog(@"cut");
}

-(IBAction)paste:(id)sender{
    NSPasteboard *pb=[NSPasteboard generalPasteboard];
    NSString* value = [pb stringForType:NSStringPboardType];
    
    
    NSLog(@"%@, paste", value);
}
*/
-(void)viewDidMoveToWindow{
    NSLog(@"view move to window");
    /*this will product many events*/
    //[[self window] setAcceptsMouseMovedEvents:YES];
    
    int option=NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingInVisibleRect;
    
    NSTrackingArea* ta;
    ta = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:option owner:self userInfo:nil];
    [self addTrackingArea:ta];
    
    text = @"hello Xcode";
    attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[NSFont fontWithName:@"Times-Roman" size:50] forKey:NSFontAttributeName];
    [attributes setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
}

-(void)mouseMoved:(NSEvent *)theEvent{
    NSLog(@"mouse moved");
}

-(void)mouseEntered:(NSEvent *)theEvent{
    NSLog(@"mouse entered");
}

-(void)mouseExited:(NSEvent *)theEvent{
    NSLog(@"mouse exited");
}

-(void)keyDown:(NSEvent *)theEvent{
    NSLog(@"%@", [theEvent characters]);
    
    /*just give to interpreter*/
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}

/*next to method used by interpreter*/
-(void)insertText:(id)insertString{
    NSLog(@"%@", insertString);
}

-(void)insertTab:(id)sender{
    [[self window] selectKeyViewFollowingView:self];
}

-(BOOL)resignFirstResponder{
    NSLog(@"resigning");
    return YES;
}

-(BOOL)becomeFirstResponder{
    NSLog(@"becoming");
    return YES;
}
-(BOOL)acceptsFirstResponder{
    NSLog(@"accetping");
    return YES;
}

-(void)mouseUp:(NSEvent *)theEvent{
    
    NSPoint pt=[theEvent locationInWindow];
    
    NSLog(@"%@", NSStringFromPoint(pt));
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        srand(time(NULL));
        
       path = [[NSBezierPath alloc] init];
        NSPoint pt = [self randomPts];
        [path moveToPoint:pt];
        
        int idx=0;
        for(; idx<20; ++idx){
            pt = [self randomPts];
            [path lineToPoint:pt];
        }
        
        [path closePath];
    }
    
    return self;
}

-(NSPoint)randomPts{
    NSPoint pt;
    NSRect r = [self bounds];
    
    pt.x = r.origin.x+random()%((int)r.size.width);
    pt.y = r.origin.y+random()%((int)r.size.height);
    
    return pt;
}

-(void)drawString:(NSRect)r{
    NSSize size = [text sizeWithAttributes:attributes];
    NSPoint pt;
    
    pt.x = r.origin.x+(r.size.width-size.width)/2;
    pt.y = r.origin.y+(r.size.height-size.height)/2;
    
    [text drawAtPoint:pt withAttributes:attributes];
}

-(IBAction)savePdf:(id)sender{
    NSData *data = [self dataWithPDFInsideRect:[self bounds]];
    
    NSString* path = @"./hello_Xcode.pdf";
    NSError *error;
    [data writeToFile:path options:0 error:&error];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    NSRect rect = [self bounds];
    [[NSColor blackColor] set];
    [NSBezierPath fillRect:rect];
    
    [[NSColor whiteColor] set];
    [path stroke];
    
    [self drawString:[self bounds]];
}

@end







