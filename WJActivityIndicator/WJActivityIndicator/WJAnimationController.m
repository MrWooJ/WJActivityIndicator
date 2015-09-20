//
//  WJAnimationDelegate.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAnimationController.h"

#import "WJAIAnimationBallBeat.h"
#import "WJAIAnimationBallClipRotate.h"
#import "WJAIAnimationBallClipRotateMultiple.h"
#import "WJAIAnimationBallClipRotatePulse.h"
#import "WJAIAnimationBallGridBeat.h"
#import "WJAIAnimationBallGridPulse.h"
#import "WJAIAnimationBallPulse.h"
#import "WJAIAnimationBallPulseRise.h"
#import "WJAIAnimationBallPulseSync.h"
#import "WJAIAnimationBallRotate.h"
#import "WJAIAnimationBallScale.h"
#import "WJAIAnimationBallScaleMultiple.h"
#import "WJAIAnimationBallScaleRipple.h"
#import "WJAIAnimationBallScaleRippleMultiple.h"
#import "WJAIAnimationBallSpinFadeLoader.h"
#import "WJAIAnimationBallTrianglePath.h"
#import "WJAIAnimationBallZigZag.h"
#import "WJAIAnimationBallZigZagDeflect.h"
#import "WJAIAnimationBlank.h"
#import "WJAIAnimationCubeTransition.h"
#import "WJAIAnimationLineScale.h"
#import "WJAIAnimationLineScaleParty.h"
#import "WJAIAnimationLineScalePulseOut.h"
#import "WJAIAnimationLineScalePulseOutRapid.h"
#import "WJAIAnimationLineSpinFadeLoader.h"
#import "WJAIAnimationPacman.h"
#import "WJAIAnimationSemiCircleSpin.h"
#import "WJAIAnimationSquareSpin.h"
#import "WJAIAnimationTriangleSkewSpin.h"

@implementation WJAnimationController

#pragma mark - Options

- (Class)findAnimationClassForType:(WJAITypes)type {
	
	switch (type) {
			
		case Blank:
			return [WJAIAnimationBlank class];
		case BallPulse:
			return [WJAIAnimationBallPulse class];
		case BallGridPulse:
			return [WJAIAnimationBallGridPulse class];
		case BallClipRotate:
			return [WJAIAnimationBallClipRotate class];
		case SquareSpin:
			return [WJAIAnimationSquareSpin class];
		case BallClipRotatePulse:
			return [WJAIAnimationBallClipRotatePulse class];
		case BallClipRotateMultiple:
			return [WJAIAnimationBallClipRotateMultiple class];
		case BallPulseRise:
			return [WJAIAnimationBallPulseRise class];
		case BallRotate:
			return [WJAIAnimationBallRotate class];
		case CubeTransition:
			return [WJAIAnimationCubeTransition class];
		case BallZigZag:
			return [WJAIAnimationBallZigZag class];
		case BallZigZagDeflect:
			return [WJAIAnimationBallZigZagDeflect class];
		case BallTrianglePath:
			return [WJAIAnimationBallTrianglePath class];
		case BallScale:
			return [WJAIAnimationBallScale class];
		case LineScale:
			return [WJAIAnimationLineScale class];
		case LineScaleParty:
			return [WJAIAnimationLineScaleParty class];
		case BallScaleMultiple:
			return [WJAIAnimationBallScaleMultiple class];
		case BallPulseSync:
			return [WJAIAnimationBallPulseSync class];
		case BallBeat:
			return [WJAIAnimationBallBeat class];
		case LineScalePulseOut:
			return [WJAIAnimationLineScalePulseOut class];
		case LineScalePulseOutRapid:
			return [WJAIAnimationLineScalePulseOutRapid class];
		case BallScaleRipple:
			return [WJAIAnimationBallScaleRipple class];
		case BallScaleRippleMultiple:
			return [WJAIAnimationBallScaleRippleMultiple class];
		case BallSpinFadeLoader:
			return [WJAIAnimationBallSpinFadeLoader class];
		case LineSpinFadeLoader:
			return [WJAIAnimationLineSpinFadeLoader class];
		case TriangleSkewSpin:
			return [WJAIAnimationTriangleSkewSpin class];
		case Pacman:
			return [WJAIAnimationPacman class];
		case BallGridBeat:
			return [WJAIAnimationBallGridBeat class];
		case SemiCircleSpin:
			return [WJAIAnimationSemiCircleSpin class];
			
		default:
			break;
	}
}

- (void)setUpAnimationForDelegateInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color Type:(WJAITypes)type {
	
	Class modelClass = [self findAnimationClassForType:type];

	id model = [[modelClass alloc]init];

	[model setUpAnimationInLayer:layer Size:size Color:color];
}

@end
