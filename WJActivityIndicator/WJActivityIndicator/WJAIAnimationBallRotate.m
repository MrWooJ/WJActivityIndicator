//
//  WJAIAnimationBallRotate.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallRotate.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallRotate

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSize = size.width / 5;
	CFTimeInterval duration = 1;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7 :-0.13 :0.22 :0.86];
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.6, @1, nil];
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	scaleAnimation.duration = duration;
	
	// Rotate Animation
	CAKeyframeAnimation *rotateAnimation = [[CAKeyframeAnimation alloc] init];
	
	rotateAnimation.keyPath = @"transform.rotation.z";
	rotateAnimation.keyTimes = scaleAnimation.keyTimes;
	rotateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithDouble:M_PI], [NSNumber numberWithDouble:(2 * M_PI)], nil];
	rotateAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	rotateAnimation.duration = duration;
	
	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, rotateAnimation, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Circles
	CALayer *leftCircle		= [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
	CALayer *rightCircle	= [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
	CALayer *centerCircle	= [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
	
	leftCircle.opacity = 0.8;
	leftCircle.frame = CGRectMake(0, (size.height - circleSize) / 2, circleSize, circleSize);
	rightCircle.opacity = 0.8;
	rightCircle.frame = CGRectMake(size.width - circleSize, (size.height - circleSize) / 2, circleSize, circleSize);
	centerCircle.frame = CGRectMake((size.width - circleSize) / 2, (size.height - circleSize) / 2, circleSize, circleSize);
	
	CALayer *circle = [[CALayer alloc]init];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
	
	circle.frame = frame;
	[circle addSublayer:leftCircle];
	[circle addSublayer:rightCircle];
	[circle addSublayer:centerCircle];
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}

@end
