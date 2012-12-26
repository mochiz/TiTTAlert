/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "TTAlertView.h"

@interface ComQnypTittalertView : TiUIView {
    TTAlertView *alert;
    NSString *title;
    NSString *message;
    NSString *cancelButtonTitle;
    NSMutableArray *otherButtonTitles;
}

-(void)show:(id)args;

@end
