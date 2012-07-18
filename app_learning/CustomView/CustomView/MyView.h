//
//  MyView.h
//  CustomView
//
//  Created by xiao lihao on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyView : NSView{
    NSBezierPath *path;
    NSMutableDictionary *attributes;
    NSString *text;
}
-(NSPoint)randomPts;
-(IBAction)savePdf:(id)sender;
@end
