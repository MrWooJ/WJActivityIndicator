//
//  WJAIAnimationBallClipRotateMultiple.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallClipRotateMultiple.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallClipRotateMultiple

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {

	// Pre Initialize Values
	float bigCircleSize = size.width;
	float smallCircleSize = size.width / 2;
	CFTimeInterval longDuration = 1;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	[self circleOfShape:RingTwoHalfHorizontal Duration:longDuration TimingFunction:timingFunction Layer:layer Size:bigCircleSize Color:color Reverse:false];
	[self circleOfShape:RingTwoHalfVertical Duration:longDuration TimingFunction:timingFunction Layer:layer Size:smallCircleSize Color:color Reverse:true];
}

- (CAAnimation *)createAnimationInDuration:(CFTimeInterval)duration TimingFunction:(CAMediaTimingFunction *)timingFunction Reverse:(BOOL)reverse {
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0 , @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.6, @1, nil];
	scaleAnimation.duration = duration;
	
	// Rotate Animation
	CAKeyframeAnimation *rotateAnimation = [[CAKeyframeAnimation alloc] init];
	
	rotateAnimation.keyPath = @"transform.rotation.z";
	rotateAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	rotateAnimation.keyTimes = [NSArray arrayWithObjects:@0 , @0.5, @1, nil];
	rotateAnimation.duration = duration;
	if (!reverse)
		rotateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithDouble:M_PI], [NSNumber numberWithDouble:(2 * M_PI)], nil];
	else
		rotateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithDouble:-M_PI], [NSNumber numberWithDouble:(-2 * M_PI)], nil];

	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, rotateAnimation, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	return animation;
}

- (void)circleOfShape:(WJAIShapes)shape Duration:(CFTimeInterval)duration TimingFunction:(CAMediaTimingFunction *)timingFunction Layer:(CALayer *)layer Size:(float)size Color:(UIColor *)color Reverse:(BOOL)reverse {
	
	// Draw Circle
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:shape Size:CGSizeMake(size, size) Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size) / 2, (layer.bounds.size.height - size) / 2, size, size);
	
	CAAnimation *animation = [self createAnimationInDuration:duration TimingFunction:timingFunction Reverse:reverse];
	
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}

@end
