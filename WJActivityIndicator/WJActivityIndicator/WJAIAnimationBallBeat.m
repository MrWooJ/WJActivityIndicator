//
//  WJAIAnimationBallBeat.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallBeat.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallBeat

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSpacing = 2;
	float circleSize = (size.width - circleSpacing * 2) / 3;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - circleSize) / 2;
	CFTimeInterval duration = 0.7;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0.35, @0 , @0.35, nil];
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.75, @1, nil];
	scaleAnimation.duration = duration;
	
	// Opacity Animation
	CAKeyframeAnimation *opacityAnimation = [[CAKeyframeAnimation alloc] init];

	opacityAnimation.keyPath = @"opacity";
	opacityAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	opacityAnimation.values = [NSArray arrayWithObjects:@1, @0.2, @1, nil];
	opacityAnimation.duration = duration;
	
	// Aniamtion
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];

	animation.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw Circles
	for (int i = 0; i < 3; i++)
	{
		CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
		CGRect frame = CGRectMake(x + circleSize * i + circleSpacing * i, y, circleSize, circleSize);
		
		animation.beginTime = beginTime + [beginTimes[i] floatValue];
		circle.frame = frame;
		[circle addAnimation:animation forKey:@"animation"];
		[layer addSublayer:circle];
	}
}

@end
