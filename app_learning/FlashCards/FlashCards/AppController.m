//
//  AppController.m
//  FlashCards
//
//  Created by xiao lihao on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "Home.h"
#import "Quiz.h"
@implementation AppController

-(void)awakeFromNib{
    [self loadHomeView];
}

-(void)clearView{
    if(_homeViewController){
        [[_homeViewController view] removeFromSuperview];
        _homeViewController = nil;
    }
    
    if(_quizViewController){
        [[_quizViewController view] removeFromSuperview];
        _quizViewController = nil;
    }
}

-(void)loadHomeView{
    
    [self clearView];
    _homeViewController = [[Home alloc] initWithNibName:@"Home"
                                                 bundle:[NSBundle mainBundle]
                                          appController:self];
    
    [_contentView addSubview:[_homeViewController view]];
}


-(void)loadQuizView{
    [self clearView];
    _quizViewController = [[Quiz alloc] initWithNibName:@"Quiz"
                                                 bundle:[NSBundle mainBundle]];
    
    [_contentView addSubview:[_quizViewController view]];
}

@end
