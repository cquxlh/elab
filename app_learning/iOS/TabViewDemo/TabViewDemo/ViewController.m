//
//  ViewController.m
//  TabViewDemo
//
//  Created by xiao lihao on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize dict=_dict;
@synthesize alpha=_alpha;
-(NSInteger)numberOfSectionsInTableView:(UITableView*)view{
    return 1;
}


-(NSInteger) tableView:(UITableView*)view numberOfRowsInSection:(NSInteger)section{
    return 10000;
}

-(UITableViewCell*) tableView:(UITableView*)view cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellStyle style=UITableViewCellStyleDefault;
    
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:@"basecell"];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"basecell"];
    
    NSString *key=[@"Row " stringByAppendingString:[self.alpha objectAtIndex:indexPath.row%26]];
    
    cell.textLabel.text=key;
    if(indexPath.row%2==0)
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    else{
        for (int i = 0; i < 6; ++i) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100 + 15 * i, 0, 30, 20)];
            label.backgroundColor = [UIColor redColor];
            label.text = [NSString stringWithFormat:@"%d", i];
            [cell.contentView addSubview:label];
        }
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        
    }
        
        
 //   cell.editingAccessoryType=UITableViewCellAccessoryNone;
    
    return cell;
}

-(void)tableView:(UITableView*)view accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", indexPath);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.alpha = [NSArray arrayWithObjects:@"A",@"B", @"C", @"D",
                  @"E",@"F", @"G", @"H",
                  @"I",@"J", @"K", @"L",
                  @"M",@"N", @"O", @"P",
                  @"Q",@"R", @"S", @"T",
                  @"U",@"V", @"W", @"X",
                  @"Y",@"Z", nil];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
