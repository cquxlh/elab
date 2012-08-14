//
//  MyTextField.m
//  MyTagView
//
//  Created by xiao lihao on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [super drawRect:dirtyRect];
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
@end
