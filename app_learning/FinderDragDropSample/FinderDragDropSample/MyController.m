//
//  MyController.m
//  FinderDragDropSample
//
//  Created by xiao lihao on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyController.h"

@implementation MyController

-(void) awakeFromNib{
  
    file_names = [[NSMutableArray alloc] init];
}

-(void) acceptFilenameDrag:(NSString*)file_name{
    [array_controller addObject:file_name];
}

@end
