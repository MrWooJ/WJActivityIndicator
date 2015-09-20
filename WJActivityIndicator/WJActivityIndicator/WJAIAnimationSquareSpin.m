//
//  WJAIAnimationSquareSpin.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationSquareSpin.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationSquareSpin

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	CFTimeInterval duration = 3;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.09 :0.57 :0.49 :0.9];

	// Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.25, @0.5, @0.75, @1, nil];
	animation.values = [NSArray arrayWithObjects:
						[NSValue valueWithCATransform3D:(CATransform3DConcat([self createRotateXTransformAngle:0], [self createRotateYTransformAngle:0]))],
						[NSValue valueWithCATransform3D:(CATransform3DConcat([self createRotateXTransformAngle:M_PI], [self createRotateYTransformAngle:0]))],
						[NSValue valueWithCATransform3D:(CATransform3DConcat([self createRotateXTransformAngle:M_PI], [self createRotateYTransformAngle:M_PI]))],
						[NSValue valueWithCATransform3D:(CATransform3DConcat([self createRotateXTransformAngle:0], [self createRotateYTransformAngle:M_PI]))],
						[NSValue valueWithCATransform3D:(CATransform3DConcat([self createRotateXTransformAngle:0], [self createRotateYTransformAngle:0]))]
						, nil];
	
	animation.duration = duration;
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, timingFunction, timingFunction, nil];
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw Square
	CALayer *square = [WJActivityIndicatorShape createLayerWithShape:Rectangle Size:size Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
	
	square.frame = frame;
	[square addAnimation:animation forKey:@"animation"];
	[layer addSublayer:square];
}

- (CATransform3D)createRotateXTransformAngle:(float)angle {
	
	CATransform3D transform = CATransform3DMakeRotation(angle, 1, 0, 0);
	
	transform.m34 = (float) (-1 / 100);
	
	return transform;
}

- (CATransform3D)createRotateYTransformAngle:(float)angle {
	
	CATransform3D transform = CATransform3DMakeRotation(angle, 0, 1, 0);
	
	transform.m34 = (float) (-1 / 100);
	
	return transform;
}

@end
