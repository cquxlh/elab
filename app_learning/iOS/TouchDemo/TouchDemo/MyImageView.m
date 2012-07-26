//
//  MyImageView.m
//  TouchDemo
//
//  Created by xiao lihao on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

@synthesize startPoint;

-(id) initWithImage:(UIImage *)image{
    if(self =[super initWithImage:image])
        self.userInteractionEnabled=YES;
    
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt=[[touches anyObject] locationInView:self];
    
    startPoint=pt;
    //[[self superview] bringSubviewToFront:self];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt=[[touches anyObject] locationInView:self];
    float cx=pt.x-startPoint.x;
    float cy=pt.y-startPoint.y;
    
    CGPoint newcenter=CGPointMake(self.center.x+cx, self.center.y+cy);
    
    self.center=newcenter;

}
@end
