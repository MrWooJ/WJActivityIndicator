//
//  WJAIAnimationPacman.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationPacman.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationPacman

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	[self circleInLayer:layer Size:size Color:color];
	[self pacmanInLayer:layer Size:size Color:color];
}

- (void)pacmanInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float pacmanSize = 2 * size.width / 3;
	CFTimeInterval pacmanDuration = 0.5;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];

	// Stroke Start Animation
	CAKeyframeAnimation *strokeStartAnimation = [[CAKeyframeAnimation alloc] init];
	
	strokeStartAnimation.keyPath = @"strokeStart";
	strokeStartAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	strokeStartAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	strokeStartAnimation.values = [NSArray arrayWithObjects:@0.125, @0, @0.125, nil];
	strokeStartAnimation.duration = pacmanDuration;

	// Stroke End Animation
	CAKeyframeAnimation *strokeEndAnimation = [[CAKeyframeAnimation alloc] init];
	
	strokeEndAnimation.keyPath = @"strokeEnd";
	strokeEndAnimation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	strokeEndAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	strokeEndAnimation.values = [NSArray arrayWithObjects:@0.875, @1, @0.875, nil];
	strokeEndAnimation.duration = pacmanDuration;

	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:strokeStartAnimation, strokeEndAnimation, nil];
	animation.duration = pacmanDuration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Pacman
	CALayer *pacman = [WJActivityIndicatorShape createLayerWithShape:Pacman Size:CGSizeMake(pacmanSize, pacmanSize) Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2 + size.height / 2 - pacmanSize / 2, pacmanSize, pacmanSize);
	
	pacman.frame = frame;
	[pacman addAnimation:animation forKey:@"animation"];
	[layer addSublayer:pacman];
}

- (void)circleInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSize = size.width / 5;
	CFTimeInterval circleDuration = 1;
	
	// Translate Animation
	CABasicAnimation *translateAnimation = [[CABasicAnimation alloc] init];
	
	translateAnimation.keyPath = @"transform.translation.x";
	translateAnimation.fromValue = @0;
	translateAnimation.toValue = [NSNumber numberWithFloat:(-size.width / 2)];
	translateAnimation.duration = circleDuration;

	// Opacity Animation
	CABasicAnimation *opacityAnimation = [[CABasicAnimation alloc] init];
	
	opacityAnimation.keyPath = @"opacity";
	opacityAnimation.fromValue = @1;
	opacityAnimation.toValue = @0.7;
	opacityAnimation.duration = circleDuration;

	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:translateAnimation, opacityAnimation, nil];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.duration = circleDuration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Circles
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:CGSizeMake(circleSize, circleSize) Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2 + size.width - circleSize, (layer.bounds.size.height - size.height) / 2 + size.height / 2 - circleSize/ 2, circleSize, circleSize);
	
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}

@end
