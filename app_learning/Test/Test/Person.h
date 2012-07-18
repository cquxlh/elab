//
//  Person.h
//  Test
//
//  Created by xiao lihao on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    NSString* name;
    int age;
}

@property (copy)NSString* name;
@property int age;
@end
