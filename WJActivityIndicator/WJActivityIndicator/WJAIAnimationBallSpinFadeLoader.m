//
//  WJAIAnimationBallSpinFadeLoader.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallSpinFadeLoader.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallSpinFadeLoader

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSpacing = -2;
	float circleSize = (size.width - 4 * circleSpacing) / 5;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	CFTimeInterval duration = 1;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0, @0.12, @0.24, @0.36, @0.48, @0.6, @0.72, @0.84, nil];
	
	// Scale Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.4, @1, nil];
	scaleAnimation.duration = duration;
	
	// Opacity Animation
	CAKeyframeAnimation *opacityAnimation = [[CAKeyframeAnimation alloc] init];
	
	opacityAnimation.keyPath = @"opacity";
	opacityAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	opacityAnimation.values = [NSArray arrayWithObjects:@1, @0.3, @1, nil];
	opacityAnimation.duration = duration;
	
	// Aniamtion
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Assign Circles
	for (int i = 0; i < 8; i++)
	{
		CALayer *circle = [self circleAtAngle:(M_PI_4 * i) Size:circleSize Origin:CGPointMake(x, y) ContainerSize:size Color:color];
		animation.beginTime = beginTime + [[beginTimes objectAtIndex:i]floatValue];
		[circle addAnimation:animation forKey:@"animation"];
		[layer addSublayer:circle];
	}
}

- (CALayer *)circleAtAngle:(float)angle Size:(float)size Origin:(CGPoint)origin ContainerSize:(CGSize)containerSize Color:(UIColor *)color {
	
	// Draw Circles
	float radius = containerSize.width / 2;
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(size, size) Color:color];
	CGRect frame = CGRectMake(origin.x + radius * (cos(angle) + 1) - size / 2, origin.y + radius * (sin(angle) + 1) - size / 2, size, size);
	
	circle.frame = frame;
	return circle;
}

@end
