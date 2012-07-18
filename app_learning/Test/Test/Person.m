//
//  Person.m
//  Test
//
//  Created by xiao lihao on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name;
@synthesize age;

-(id)init{
    if(![super init])
        return nil;
    
    name = @"new person";
    age = 12;
    
    return self;
}
@end
