//
//  Foo.h
//  Test
//
//  Created by xiao lihao on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface Foo : NSObject{
IBOutlet NSTextField* textField;
}
-(IBAction)genSeed:(id)sender;
-(IBAction)genData:(id)sender;
@end
