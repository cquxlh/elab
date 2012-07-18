//
//  MyViewDelegate.m
//  CustomView
//
//  Created by xiao lihao on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyViewDelegate.h"

@implementation MyViewDelegate
-(IBAction)copy:(id)sender{
    NSLog(@"copy");
    
    NSPasteboard *pb=[NSPasteboard generalPasteboard];
    [pb declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
    [pb setString:@"it's main windows's delegate" forType:NSStringPboardType];
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
@end
