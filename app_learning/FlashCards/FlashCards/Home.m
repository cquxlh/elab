//
//  Home.m
//  FlashCards
//
//  Created by xiao lihao on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Home.h"
#import "AppController.h"

@implementation Home

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil appController:(AppController *)appController{
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        _appController = appController;
        
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(IBAction)startQuizAction:(id)sender{
    [_appController loadQuizView];
}
@end
