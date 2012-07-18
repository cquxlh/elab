//
//  AppController.m
//  AddPanel
//
//  Created by xiao lihao on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "MyPanelController.h"

@implementation AppController


-(id)init{
    if(![super init])
        return nil;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(testNotification:) name:@"testNotification" object:nil];
    
    return self;
}

-(void)testNotification:(NSNotification*)no{
    NSString *s = [[no userInfo] objectForKey:@"world"];
    if(s)
        NSLog(@"%@", s);
    
    NSLog(@"test notification");
}

-(IBAction)showPanel:(id)sender{
    if(!aReference)
        aReference = [[MyPanelController alloc] init];
    
    [aReference showWindow:self];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"testNotification" object:self];
}

@end
