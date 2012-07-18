#import "Controller.h"

@implementation Controller

- (void) awakeFromNib
{
	filenames = [[NSMutableArray alloc] init];
}

- (void) acceptFilenameDrag:(NSString *) filename
{
	[arrayController addObject:filename];
}

@end
