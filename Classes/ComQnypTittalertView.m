/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComQnypTittalertView.h"
#import "TiUtils.h"
#import "TTAlertView.h"

@implementation ComQnypTittalertView
-(void)dealloc
{
    [super dealloc];
}

-(void)setTitle_:(id)value {
    title = [TiUtils stringValue:value];
}

-(void)setMessage_:(id)value {
    message = [TiUtils stringValue:value];
}

-(void)setCancelButtonTitle_:(id)value {
    cancelButtonTitle = [TiUtils stringValue:value];
}
-(void)setOtherButtonTitle_:(id)value {
    // 複数のボタンには対応していません
    otherButtonTitle = value;
}

- (void)styleCustomAlertView:(TTAlertView *)alertView
{
    [alertView.containerView setImage:[[UIImage imageNamed:@"modules/com.qnyp.tittalert/alert.bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(11.0f, 13.0f, 14.0f, 13.0f)]];
    [alertView.containerView setBackgroundColor:[UIColor clearColor]];

    alertView.buttonInsets = UIEdgeInsetsMake(alertView.buttonInsets.top, alertView.buttonInsets.left + 4.0f, alertView.buttonInsets.bottom + 6.0f, alertView.buttonInsets.right + 4.0f);
}

- (void)addButtonsWithBackgroundImagesToAlertView:(TTAlertView *)alertView
{
    UIImage *redButtonImageOff = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.red.off.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0];
    UIImage *redButtonImageOn = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.red.on.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0];

    UIImage *greenButtonImageOff = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.green.off.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0];
    UIImage *greenButtonImageOn = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.green.on.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0];

    for(int i = 0; i < [alertView numberOfButtons]; i++) {
        if (i == 0) {
            [alertView setButtonBackgroundImage:redButtonImageOff forState:UIControlStateNormal atIndex:i];
//            [alertView setButtonBackgroundImage:redButtonImageOn forState:UIControlStateHighlighted atIndex:i];
        } else {
            [alertView setButtonBackgroundImage:greenButtonImageOff forState:UIControlStateNormal atIndex:i];
//            [alertView setButtonBackgroundImage:greenButtonImageOn forState:UIControlStateHighlighted atIndex:i];
        }
    }
}

# pragma mark Public APIs

- (void)show:(id)args {
    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:otherButtonTitle, nil];
    [self styleCustomAlertView:alertView];
    [self addButtonsWithBackgroundImagesToAlertView:alertView];
    [alertView show];
}

#pragma mark TTAlertView Delegate

- (void)alertView:(TTAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ([self.proxy _hasListeners:@"click"])
	{
        NSInteger cancel = 0;
        if (buttonIndex == alertView.cancelButtonIndex) {
            cancel = 1;
        }
        NSLog(@"cancel:%d", cancel);
		NSMutableDictionary *event = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:buttonIndex],@"index",
                                      [NSNumber numberWithInt:cancel],@"cancel",
                                      nil];
		[self.proxy fireEvent:@"click" withObject:event];
	}
}

@end
