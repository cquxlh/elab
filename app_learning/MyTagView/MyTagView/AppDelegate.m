//
//  AppDelegate.m
//  MyTagView
//
//  Created by xiao lihao on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#include "TagView.h"
#import "MyTextField.h"
#include "BackView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate
@synthesize textView = _textView;

@synthesize tagView = _tagView;
@synthesize scrollView = _scrollView;
@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
   // [self.textView setWantsLayer:true];
  //  [self.scrollView setWantsLayer:true];
   // [[self.textView layer] setMasksToBounds:YES];
   // [[self.textView layer] setCornerRadius:10];
    
   // [[self.scrollView layer] setMasksToBounds:YES];
  //  [[self.scrollView layer] setCornerRadius:10];
}

- (CGImageRef)nsImageToCGImageRef:(NSImage*)image{
    NSData * imageData = [image TIFFRepresentation]; CGImageRef imageRef;
    if(imageData)
    {
        CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
        imageRef =
        CGImageSourceCreateImageAtIndex(imageSource, 0, NULL); }
    return imageRef;
}
- (void)AddTagWithText:(NSString*)text{
    
    static int idx=0;
    CGRect rect = CGRectMake(self.tagView.offset, 0, 75, 20);
    self.tagView.offset+=77;
    
    NSButton *tf = [[NSButton alloc] initWithFrame:rect];
    
    //MyTextField *tf = [[MyTextField alloc] initWithFrame:rect];
    //[tf setTitle:[NSString stringWithFormat:@"#tag%d", idx++]];
    
    
    
    [tf setWantsLayer:YES];
    [[tf layer] setMasksToBounds:YES];
    [[tf layer] setCornerRadius:10];
    
    
    CALayer *topLayer = [CALayer layer];
    NSImage *image=[NSImage imageNamed:@"imge1.png"];
 
    CGImageRef img=[self nsImageToCGImageRef:image];
    topLayer.contents=image;
   // [topLayer setContents:img];
    topLayer.position=CGPointMake(37.5f,10.0f);
    topLayer.bounds=CGRectMake(0.0f,0.0f,75.0f,20.0f);
    
    
    CATextLayer *textLayer = [CATextLayer layer];
    [textLayer setForegroundColor:CGColorGetConstantColor(kCGColorBlack)]; 
    [textLayer setFontSize:15.0f];
    [textLayer setAlignmentMode:kCAAlignmentCenter]; 
    [textLayer setString:[NSString stringWithFormat:@"#tag%d", idx++]];
    CGRect textRect;
    textRect.size = [textLayer preferredFrameSize]; 
    [textLayer setBounds:textRect];
    [textLayer setPosition:CGPointMake(37.5, 9)];
    [topLayer addSublayer:textLayer];
    
    [tf setLayer:topLayer];
    [self.tagView addSubview:tf];
   // topLayer.backgroundColor=CGColorCreateGenericRGB(0, 0, 1, 0);
    //[topLayer setPosition:CGPointMake(30, 10)];
    //[[self.window contentView ] setWantsLayer:YES];
   /// [[[self.window contentView] layer] addSublayer:topLayer];
   // [topLayer setNeedsDisplay];

    //[[tf layer] addSublayer:topLayer];
    //[self.tagView addSubview:tf];
    //[[self.tagView layer] addSublayer:topLayer];
    //[self.tagView setWantsLayer:YES];
    //[self.tagView setLayer:topLayer];
    
    
    
    /*BackView *topView=[[BackView alloc] initWithFrame:
                       CGRectMake(0, 0, tf.frame.size.width, tf.frame.size.height)];
    topView.autoresizingMask=tf.autoresizingMask;
    [topView setAcceptsTouchEvents:NO];
    [topView setAlphaValue:0.3];
    //topView.alpha=0.5;

    //[tf setBackgroundColor:[NSColor blackColor]];
    [tf addSubview:topView];
    
    [tf setWantsLayer:YES];
    [[tf layer] setMasksToBounds:YES];
    [[tf layer] setCornerRadius:10];
    //[[tf cell] setBezelStyle:NSTextFieldRoundedBezel];
    //[[tf cell] setPlaceholderString:@"NewTag"];
    
    //[tf setSelectable:YES];
   // [tf setEditable:YES];

    [self.tagView addSubview:tf];*/
  //  [tf selectText:self];
}

- (IBAction)AddTag:(id)sender {
    [self AddTagWithText:@"tf"];
}
@end
