//
//  WJAIAnimationBallPulseRise.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallPulseRise.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallPulseRise

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSpacing = 2;
	float circleSize = (size.width - 4 * circleSpacing) / 5;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - circleSize) / 2;
	float deltaY = size.height / 2;
	CFTimeInterval duration = 1;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.15 :0.46 :0.9 :0.6];

	CAAnimation *oddAnimation	= [self oddAnimationWithDuration:duration DeltaY:deltaY TimingFunction:timingFunction];
	CAAnimation *evenAnimation	= [self evenAnimationWithDuration:duration DeltaY:deltaY TimingFunction:timingFunction];
	
	// Draw Circles
	for (int i = 0; i < 5; i++)
	{
		CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
		CGRect frame = CGRectMake((x + circleSize * i + circleSpacing * i), (y), circleSize, circleSize);
		
		circle.frame = frame;

		if (i % 2 == 0)
			[circle addAnimation:evenAnimation forKey:@"animation"];
		else
			[circle addAnimation:oddAnimation forKey:@"animation"];
		
		[layer addSublayer:circle];
	}
}

- (CAAnimation *)oddAnimationWithDuration:(CFTimeInterval)duration DeltaY:(float)deltaY TimingFunction:(CAMediaTimingFunction*)timingFunction {
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@0.4, @1.1, @0.75, nil];
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	scaleAnimation.duration = duration;
	
	// Translate Animation
	CAKeyframeAnimation *translateAnimation = [[CAKeyframeAnimation alloc] init];
	
	translateAnimation.keyPath = @"transform.translation.y";
	translateAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.25, @0.75, @1, nil];
	translateAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	translateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithFloat:deltaY], [NSNumber numberWithFloat:(-1 * deltaY)], @0, nil];
	translateAnimation.duration = duration;
	
	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, translateAnimation, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	return animation;
}

- (CAAnimation *)evenAnimationWithDuration:(CFTimeInterval)duration DeltaY:(float)deltaY TimingFunction:(CAMediaTimingFunction*)timingFunction {
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1.1, @0.4, @1, nil];
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	scaleAnimation.duration = duration;
	
	// Translate Animation
	CAKeyframeAnimation *translateAnimation = [[CAKeyframeAnimation alloc] init];
	
	translateAnimation.keyPath = @"transform.translation.y";
	translateAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.25, @0.75, @1, nil];
	translateAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	translateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithFloat:(-1 * deltaY)], [NSNumber numberWithFloat:deltaY], @0, nil];
	translateAnimation.duration = duration;
	
	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, translateAnimation, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	return animation;
}

@end
