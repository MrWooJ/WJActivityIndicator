//
//  WJAIAnimationBallPulseSync.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallPulseSync.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallPulseSync

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSpacing = 2;
	float circleSize = (size.width - circleSpacing * 2) / 3;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - circleSize) / 2;
	float deltaY = (size.height / 2 - circleSize / 2) / 2;
	CFTimeInterval duration  = 0.6;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0.07, @0.14, @0.21, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	// Translate Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform.translation.y";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.33, @0.66, @1, nil];
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	animation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithFloat:deltaY], [NSNumber numberWithFloat:(-1 * deltaY)], @0, nil];
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
