//
//  WJAIAnimationBallScaleRipple.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallScaleRipple.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallScaleRipple

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	CFTimeInterval duration = 1;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.21 :0.53 :0.56 :0.8];
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.7, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@0.1, @1, nil];
	scaleAnimation.duration = duration;
	scaleAnimation.timingFunction = timingFunction;
	
	// Opacity Animation
	CAKeyframeAnimation *opacityAnimation = [[CAKeyframeAnimation alloc] init];
	
	opacityAnimation.keyPath = @"opacity";
	opacityAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.7, @1, nil];
	opacityAnimation.values = [NSArray arrayWithObjects:@1, @0.7, @0, nil];
	opacityAnimation.duration = duration;
	opacityAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];

	
	// Aniamtion
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Ring
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Ring Size:size Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
	
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}


@end
