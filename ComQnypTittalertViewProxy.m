/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComQnypTittalertViewProxy.h"
#import "TiUtils.h"

@implementation ComQnypTittalertViewProxy

-(void)show:(id)args
{
	[[self view] performSelectorOnMainThread:@selector(show:) withObject:args waitUntilDone:NO];
}


@end
