//
//  WJActivityIndicatorView.h
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, WJAITypes) {

	Blank					= 0,
	BallPulse				= 1,
	BallGridPulse			= 2,
	BallClipRotate			= 3,
	SquareSpin				= 4,
	BallClipRotatePulse		= 5,
	BallClipRotateMultiple	= 6,
	BallPulseRise			= 7,
	BallRotate				= 8,
	CubeTransition			= 9,
	BallZigZag				= 10,
	BallZigZagDeflect		= 11,
	BallTrianglePath		= 12,
	BallScale				= 13,
	LineScale				= 14,
	LineScaleParty			= 15,
	BallScaleMultiple		= 16,
	BallPulseSync			= 17,
	BallBeat				= 18,
	LineScalePulseOut		= 19,
	LineScalePulseOutRapid	= 20,
	BallScaleRipple			= 21,
	BallScaleRippleMultiple = 22,
	BallSpinFadeLoader		= 23,
	LineSpinFadeLoader		= 24,
	TriangleSkewSpin		= 25,
	Pacman					= 26,
	BallGridBeat			= 27,
	SemiCircleSpin			= 28,
	
}types;

@interface WJActivityIndicatorView : UIView

- (void)startAnimation;

- (void)completeWithFrame:(CGRect)frame Type:(WJAITypes)type Color:(UIColor *)color Size:(CGSize)size;

@end
