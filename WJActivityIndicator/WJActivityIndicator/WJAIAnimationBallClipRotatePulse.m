//
//  WJAIAnimationBallClipRotatePulse.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallClipRotatePulse.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallClipRotatePulse

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {

	// Pre Initialize Values
	CFTimeInterval duration = 1;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.09 :0.57 :0.49 :0.9];
	
	[self smallCircleWithDuration:duration TimingFunction:timingFunction Layer:layer Size:size Color:color];
	[self bigCircleWithDuration:duration TimingFunction:timingFunction Layer:layer Size:size Color:color];
}

- (void)smallCircleWithDuration:(CFTimeInterval)duration TimingFunction:(CAMediaTimingFunction *)timingFunction Layer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0 , @0.3, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.3, @1, nil];
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	scaleAnimation.duration = duration;
	scaleAnimation.repeatCount = HUGE;
	scaleAnimation.removedOnCompletion = false;
	
	// Draw Circle
	float circleSize = size.width / 2;
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
	
	circle.frame = frame;
	[circle addAnimation:scaleAnimation forKey:@"animation"];
	[layer addSublayer:circle];
}

- (void)bigCircleWithDuration:(CFTimeInterval)duration TimingFunction:(CAMediaTimingFunction *)timingFunction Layer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0 , @0.5, @1, nil];
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.6, @1, nil];
	scaleAnimation.duration = duration;

	// Rotate Animation
	CAKeyframeAnimation *rotateAnimation = [[CAKeyframeAnimation alloc] init];
	
	rotateAnimation.keyPath = @"transform.rotation.z";
	rotateAnimation.keyTimes = scaleAnimation.keyTimes;
	rotateAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	rotateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithDouble:M_PI], [NSNumber numberWithDouble:(2 * M_PI)], nil];
	rotateAnimation.duration = duration;
	
	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, rotateAnimation, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Ring Two Half Vertical
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:RingTwoHalfVertical Size:size Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
	
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}

@end
