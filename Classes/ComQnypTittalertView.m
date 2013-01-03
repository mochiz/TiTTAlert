/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComQnypTittalertView.h"
#import "TiUtils.h"
#import "TTAlertView.h"

static NSCondition* alertCondition;
static BOOL alertShowing = NO;

@implementation ComQnypTittalertView
-(void)dealloc
{
    RELEASE_TO_NIL(title);
    RELEASE_TO_NIL(message);
    RELEASE_TO_NIL(cancelButtonTitle);
    RELEASE_TO_NIL(otherButtonTitles);
    [super dealloc];
}

-(void)setTitle_:(id)value {
    title = [TiUtils stringValue:[self.proxy valueForUndefinedKey:@"title"]];
}

-(void)setMessage_:(id)value {
    message = [TiUtils stringValue:[self.proxy valueForUndefinedKey:@"message"]];
}

-(void)setCancelButtonTitle_:(id)value {
    cancelButtonTitle = [TiUtils stringValue:[self.proxy valueForUndefinedKey:@"cancelButtonTitle"]];
}

-(void)setOtherButtonTitles_:(id)value {
    otherButtonTitles = [self.proxy valueForUndefinedKey:@"otherButtonTitles"];
    ENSURE_TYPE(otherButtonTitles, NSArray);
}

- (void)styleCustomAlertView:(TTAlertView *)alertView
{
    [alertView.containerView setImage:[[UIImage imageNamed:@"modules/com.qnyp.tittalert/alert.bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(11.0f, 13.0f, 14.0f, 13.0f)]];
    [alertView.containerView setBackgroundColor:[UIColor clearColor]];
    [alertView.containerView setAlpha:0.9f];
    
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
    if (alertCondition==nil)
    {
            alertCondition = [[NSCondition alloc] init];
    }
    // prevent more than one JS thread from showing an alert box at a time
    if ([NSThread isMainThread]==NO)
    {
      // TODO: ここ何やってるのかよくわかってない
//		[self rememberSelf];
		
        [alertCondition lock];
        if (alertShowing) {
            [alertCondition wait];
		}
        alertShowing = YES;
        [alertCondition unlock];
        // alert show should block the JS thread like the browser
        TiThreadPerformOnMainThread(^{[self show:args];}, YES);
	} else {
        if (message == NULL && title == NULL && cancelButtonTitle == NULL) {
            title = [TiUtils stringValue:[self.proxy valueForUndefinedKey:@"title"]];
            message = [TiUtils stringValue:[self.proxy valueForUndefinedKey:@"message"]];
            cancelButtonTitle = [TiUtils stringValue:[self.proxy valueForUndefinedKey:@"cancelButtonTitle"]];
            otherButtonTitles = [self.proxy valueForUndefinedKey:@"otherButtonTitles"];
            ENSURE_TYPE(otherButtonTitles, NSMutableArray);
        }
        TTAlertView *alert = [[TTAlertView alloc] initWithTitle:title
                                           message:message
                                          delegate:self
                                 cancelButtonTitle:cancelButtonTitle
                                 otherButtonTitles:otherButtonTitles];
        [self styleCustomAlertView:alert];
        [self addButtonsWithBackgroundImagesToAlertView:alert];
        [self retain];
        [alert show];
    }
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
