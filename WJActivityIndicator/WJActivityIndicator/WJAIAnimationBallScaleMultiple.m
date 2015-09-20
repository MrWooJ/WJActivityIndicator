//
//  WJAIAnimationBallScaleMultiple.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallScaleMultiple.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallScaleMultiple

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	CFTimeInterval duration = 1;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0, @0.2, @0.4, nil];

	// Scale Animation
	CABasicAnimation *scaleAnimation = [[CABasicAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.duration = duration;
	scaleAnimation.fromValue = @0;
	scaleAnimation.toValue = @1;
	
	// Opacity Animation
	CAKeyframeAnimation *opacityAnimation = [[CAKeyframeAnimation alloc] init];
	
	opacityAnimation.keyPath = @"opacity";
	opacityAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.05, @1, nil];
	opacityAnimation.values = [NSArray arrayWithObjects:@0, @1, @0, nil];
	opacityAnimation.duration = duration;
	
	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Circle Balls
	for (int i = 0; i < 3; i++)
	{
		CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:size Color:color];
		CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
		
		animation.beginTime = beginTime + [[beginTimes objectAtIndex:i]floatValue];
		circle.frame = frame;
		circle.opacity = 0;
		[circle addAnimation:animation forKey:@"animation"];
		[layer addSublayer:circle];
	}
}


@end
