//
//  SecondView.m
//  NavigationDemo
//
//  Created by xiao lihao on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondView.h"

@implementation SecondView

-(void)segAction:(id)sender{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            NSLog(@"click x");
            break;
        case 1:
            NSLog(@"click y");
            break;
        default:
            break;
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //self.title=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];arr
        NSArray *array=[NSArray arrayWithObjects:@"X", @"y", nil];
        UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:array];
        control.segmentedControlStyle = UISegmentedControlSegmentCenter;  

        [control addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView=control;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
