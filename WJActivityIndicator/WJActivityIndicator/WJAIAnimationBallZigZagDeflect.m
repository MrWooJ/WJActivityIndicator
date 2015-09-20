//
//  WJAIAnimationBallZigZagDeflect.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallZigZagDeflect.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallZigZagDeflect

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSize = size.width / 5;
	CFTimeInterval duration = 0.75;
	float deltaX = size.width / 2 - circleSize / 2;
	float deltaY = size.height / 2 - circleSize / 2;
	CGRect frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
	
	// Circle 1 Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.33, @0.66, @1, nil];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.values = [NSArray arrayWithObjects:
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)],
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-deltaX, -deltaY, 0)],
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(deltaX, -deltaY, 0)],
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)] , nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.autoreverses = YES;
	animation.removedOnCompletion = false;
	
	// Draw Circle 1
	[self circleAtFrame:frame Layer:layer Size:CGSizeMake(circleSize, circleSize) Color:color Animation:animation];

	
	// Circle 2 Animation
	animation.values = [NSArray arrayWithObjects:
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)],
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(deltaX, deltaY, 0)],
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-deltaX, deltaY, 0)],
						[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)] , nil];
	
	// Draw Circle 2
	[self circleAtFrame:frame Layer:layer Size:CGSizeMake(circleSize, circleSize) Color:color Animation:animation];
}

- (void)circleAtFrame:(CGRect)frame Layer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color Animation:(CAAnimation *)animation {
	
	// Draw Circle
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:Circle Size:size Color:color];
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}


@end
