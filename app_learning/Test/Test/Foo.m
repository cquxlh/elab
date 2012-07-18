//
//  Foo.m
//  Test
//
//  Created by xiao lihao on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Foo.h"

@implementation Foo

-(NSString*)description{
    return @"this is Foo description";
}

-(IBAction)genSeed:(id)sender{
   // NSAssert(0!=0,@"0==0");
    srand(time(NULL));
    [textField setStringValue:@"genSeed"];
    NSLog(@"%@", self);
}

-(IBAction)genData:(id)sender{
    int value;
    value = rand()%100;

    [textField setIntValue:value];
}

-(void)awakeFromNib{
    NSCalendarDate* now;
    
    now = [NSCalendarDate calendarDate];
    [textField setObjectValue:now];
}
@end
