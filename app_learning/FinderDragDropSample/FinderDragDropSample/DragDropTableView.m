//
//  DragDropTableView.m
//  FinderDragDropSample
//
//  Created by xiao lihao on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DragDropTableView.h"

@implementation DragDropTableView
- (void) awakeFromNib
{
	// Register to accept filename drag/drop
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{

	if ([self delegate]==nil)
	{
		return NSDragOperationNone;
	}
	
	if ([[[sender draggingPasteboard] types] containsObject:NSFilenamesPboardType])
	{
		return NSDragOperationCopy;
	}
	
	return NSDragOperationNone;
}


- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
	return [self draggingEntered:sender];
}


- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	int i;
	NSPasteboard *pboard;
	pboard = [sender draggingPasteboard];
	if ([[pboard types] containsObject:NSFilenamesPboardType])
	{
		id delegate = [self delegate];
		NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
		if ([delegate respondsToSelector:@selector(acceptFilenameDrag:)])
		{
			for (i=0;i<[filenames count];i++)
			{
				[delegate performSelector:@selector(acceptFilenameDrag:) withObject:[filenames objectAtIndex:i]];
			}
		}
        
        [self reloadData];
		return YES;
	}
	return NO;
}	
@end
