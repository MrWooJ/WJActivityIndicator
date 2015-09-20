//
//  WJAIAnimationBallGridBeat.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallGridBeat.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallGridBeat

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSpacing = 2;
	float circleSize = (size.width - circleSpacing * 2) / 3;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	NSArray *durations = [NSArray arrayWithObjects:@0.96, @0.93, @1.19, @1.13, @1.34, @0.94, @1.2, @0.82, @1.19, nil];
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0.36, @0.4, @0.68, @0.41, @0.71, @-0.15, @-0.12, @0.01, @0.32, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	
	// Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"opacity";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	animation.values = [NSArray arrayWithObjects:@1, @0.7, @1, nil];
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw circles
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
