//
//  WJAIAnimationBallScale.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallScale.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallScale

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	CFTimeInterval duration = 1;
	
	// Scale Animation
	CABasicAnimation *scaleAnimation = [[CABasicAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.duration = duration;
	scaleAnimation.fromValue = @0;
	scaleAnimation.toValue = @1;
	
	// Opacity Animation
	CABasicAnimation *opacityAnimation = [[CABasicAnimation alloc] init];
	
	opacityAnimation.keyPath = @"opacity";
	opacityAnimation.duration = duration;
	opacityAnimation.fromValue = @1;
	opacityAnimation.toValue = @0;
	
	// Aniamtion
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Circles
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:size Color:color];
	CGRect frame = CGRectMake(((layer.bounds.size.width - size.width) / 2), ((layer.bounds.size.height - size.height) / 2), size.width, size.height);
	
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}


@end
