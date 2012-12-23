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
    RELEASE_TO_NIL(square);
    [super dealloc];
}

-(UIView*)square
{
    if (square==nil)
    {
        square = [[UIView alloc] initWithFrame:[self frame]];
        [self addSubview:square];
    }
    return square;
}
-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (square!=nil)
    {
        [TiUtils setView:square positionRect:bounds];
    }
}

-(void)setColor_:(id)color
{
    UIColor *c = [[TiUtils colorValue:color] _color];
    UIView *s = [self square];
    s.backgroundColor = c;
}

+(NSString*)moduleId
{
	return @"com.qnyp.tittalert";
}

+(NSString*)imagePath:(NSString*)name
{
    NSString *path = [NSString stringWithFormat:@"modules/%@/%@.png", [self moduleId], name];
    return path;
}

- (void)styleCustomAlertView:(TTAlertView *)alertView
{
    [alertView.containerView setImage:[[UIImage imageNamed:@"modules/com.qnyp.tittalert/alert.bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(11.0f, 13.0f, 14.0f, 13.0f)]];
    [alertView.containerView setBackgroundColor:[UIColor clearColor]];
    
    alertView.buttonInsets = UIEdgeInsetsMake(alertView.buttonInsets.top, alertView.buttonInsets.left + 4.0f, alertView.buttonInsets.bottom + 6.0f, alertView.buttonInsets.right + 4.0f);
}

- (void)addButtonsWithBackgroundImagesToAlertView:(TTAlertView *)alertView
{
    UIImage *redButtonImageOff = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.red.off.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:2.0];
    UIImage *redButtonImageOn = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.red.on.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:2.0];
    
    UIImage *greenButtonImageOff = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.green.off.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:2.0];
    UIImage *greenButtonImageOn = [[UIImage imageNamed:@"modules/com.qnyp.tittalert/large.button.green.on.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:2.0];
    
    for(int i = 0; i < [alertView numberOfButtons]; i++) {
        if (i == 0) {
            [alertView setButtonBackgroundImage:redButtonImageOff forState:UIControlStateNormal atIndex:i];
            [alertView setButtonBackgroundImage:redButtonImageOn forState:UIControlStateHighlighted atIndex:i];
        } else {
            [alertView setButtonBackgroundImage:greenButtonImageOff forState:UIControlStateNormal atIndex:i];
            [alertView setButtonBackgroundImage:greenButtonImageOn forState:UIControlStateHighlighted atIndex:i];
        }
    }
}

# pragma mark Public APIs

- (void)show:(id)args {
    ENSURE_SINGLE_ARG(args,NSDictionary);
    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Long Text" message:@"hogehoge" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Test", nil];
    [self styleCustomAlertView:alertView];
    [self addButtonsWithBackgroundImagesToAlertView:alertView];
    [alertView show];
}

@end
