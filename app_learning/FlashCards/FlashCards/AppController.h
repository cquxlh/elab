//
//  AppController.h
//  FlashCards
//
//  Created by xiao lihao on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Home;
@class Quiz;
@interface AppController : NSObject{

    IBOutlet NSView* _contentView;
    
    Home* _homeViewController;
    Quiz* _quizViewController;
    
}

-(void)clearView;
-(void)loadHomeView;
-(void)loadQuizView;
@end
