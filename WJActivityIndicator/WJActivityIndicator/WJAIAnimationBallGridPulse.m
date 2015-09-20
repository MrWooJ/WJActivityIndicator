//
//  WJAIAnimationBallGridPulse.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallGridPulse.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallGridPulse

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSpacing  = 2;
	float circleSize = (size.width - circleSpacing * 2) / 3;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	NSArray *durations = [NSArray arrayWithObjects:@0.72, @1.02, @1.28, @1.42, @1.45, @1.18, @0.87, @1.45, @1.06, nil];
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@-0.06, @0.25, @-0.17, @0.48, @0.31, @0.03, @0.46, @0.78, @0.45, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];

	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0 , @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.5, @1, nil];
	
	// Opacity Animation
	CAKeyframeAnimation *opacityAnimation = [[CAKeyframeAnimation alloc] init];
	
	opacityAnimation.keyPath = @"opacity";
	opacityAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	opacityAnimation.values = [NSArray arrayWithObjects:@1, @0.7, @1, nil];
	
	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw Circles
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
			CGRect frame = CGRectMake((x + circleSize * j + circleSpacing * j), (y + circleSize * i + circleSpacing * i), circleSize, circleSize);
			
			animation.duration = [[durations objectAtIndex:(3 * i + j)] floatValue];
			animation.beginTime = beginTime + [[beginTimes objectAtIndex:(3 * i + j)] floatValue];
			
			circle.frame = frame;
			[circle addAnimation:animation forKey:@"animation"];
			[layer addSublayer:circle];
		}
	}
}


@end
