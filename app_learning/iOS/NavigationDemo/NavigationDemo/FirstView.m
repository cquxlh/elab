//
//  FirstView.m
//  NavigationDemo
//
//  Created by xiao lihao on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstView.h"
#import "SecondView.h"
@implementation FirstView

-(void)clickRight{
    NSLog(@"right buttion clicked");
    SecondView *view = [[SecondView alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(clickRight)];
        //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hello" style:UIBarButtonItemStyleDone target:self action:@selector(clickRight)];
        
        /*back button should set in current View*/
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"First" style:UIBarButtonItemStyleDone target:nil action:nil];  
        self.navigationItem.backBarButtonItem  = backButton;
        
        self.title=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
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
