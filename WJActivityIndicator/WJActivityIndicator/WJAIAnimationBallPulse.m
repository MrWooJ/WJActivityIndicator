//
//  WJAIAnimationBallPulse.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallPulse.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallPulse

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSpacing = 2;
	float circleSize = (size.width - 2 * circleSpacing) / 3;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - circleSize) / 2;
	CFTimeInterval duration  = 0.75;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0.12, @0.24, @0.36, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :0.68 :0.18 :1.08];

	// Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform.scale";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.3, @1, nil];
	animation.values = [NSArray arrayWithObjects:@1, @0.3, @1, nil];
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Circles
	for (int i = 0; i < 3; i++)
	{
		CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
		CGRect frame = CGRectMake((x + circleSize * i + circleSpacing * i), (y), circleSize, circleSize);
		
		animation.beginTime = beginTime + [[beginTimes objectAtIndex:i]floatValue];
		
		circle.frame = frame;
		[circle addAnimation:animation forKey:@"animation"];
		[layer addSublayer:circle];
	}
}


@end
