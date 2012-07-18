//
//  AppController.m
//  Test
//
//  Created by xiao lihao on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

@implementation AppController

-(void)insertObject:(Person *)p inPersonAtIndex:(int)index{
    NSLog(@"insert");
}

-(NSSize)windowWillResize:(NSWindow*)w
                   toSize:(NSSize)frameSize{
    int oldWidth = [w frame].size.width;
    int oldHeight= [w frame].size.height;
    
    frameSize.width = 1.2*oldWidth;
    frameSize.height = 1.2*oldHeight;
    
    return frameSize;
}

/*(KVC/KVO)binding:当使用 accessor 方法或 key-value coding 方法去改变 key 的值,观察者可以自动得到改变的通知*/
/*key point of delegate*/
/*when a event occurr, target will check it's delegate(if exsits) whether has a method needed*/
- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSString *methodName = NSStringFromSelector(aSelector); 
    NSLog(@"respondsToSelector:%@", methodName);
    return [super respondsToSelector:aSelector];
}

-(void)tableViewSelectionDidChange:(NSNotification*)notifacation{
    int row = [view selectedRow];
    if(row == -1)
        return;
    
    NSString* str = [array objectAtIndex:row];
    [speech setVoice:str];
}
                                   
-(int)numberOfRowsInTableView:(NSTableView*)tv{
    return [array count];
}

-(id)tableView:(NSTableView*)tv
objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString* str = [array objectAtIndex:row];
    NSDictionary* dic = [NSSpeechSynthesizer attributesForVoice:str];
    
    return [dic valueForKey:NSVoiceName];
}

-(id)init{
    if(![super init])
        return nil;
    
    person = [[NSMutableArray alloc] init];
    speech = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
    [speech setDelegate:self];
    array = [NSSpeechSynthesizer availableVoices ];
    
    [speak setEnabled:YES];
    [stop setEnabled:NO];
    
    return self;
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
        didFinishSpeaking:(BOOL)finishedSpeaking{
    
    [speak setEnabled:YES];
    [stop setEnabled:NO];
    [view setEnabled:YES];
}
-(IBAction)sayIt:(id)sender{
    NSString *str = [textField stringValue];
    
    if([str length] == 0){
        NSLog(@"please input your some words");
        return;
    }
    
    [speech startSpeakingString:str];
    [speak setEnabled:NO];
    [stop setEnabled:YES];
    [view setEnabled:NO];
}

-(IBAction)stopIt:(id)sender{
    [speech stopSpeaking];
}

@end
