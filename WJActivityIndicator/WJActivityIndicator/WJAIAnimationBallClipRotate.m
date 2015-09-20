//
//  WJAIAnimationBallClipRotate.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallClipRotate.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallClipRotate

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {

	// Pre Initialize Values
	CFTimeInterval duration = 0.75;
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.6, @1, nil];
	
	// Rotate Animation
	CAKeyframeAnimation *rotateAnimation = [[CAKeyframeAnimation alloc] init];
	
	rotateAnimation.keyPath = @"transform.rotation.z";
	rotateAnimation.keyTimes = scaleAnimation.keyTimes;
	rotateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithDouble:M_PI], [NSNumber numberWithDouble:(M_PI * 2)], nil];

	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, rotateAnimation, nil];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw circle
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:RingThirdFour Size:CGSizeMake(size.width, size.height) Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
	
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}

@end
