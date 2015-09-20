//
//  WJAIAnimationCubeTransition.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationCubeTransition.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationCubeTransition

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float squareSize = size.width / 5;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	float deltaX = size.width - squareSize;
	float deltaY = size.height - squareSize;
	CFTimeInterval duration = 1.6;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0, @-0.8, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

	// Transform Animation
	CAKeyframeAnimation *scaleAnimation = [[CAKeyframeAnimation alloc] init];
	
	scaleAnimation.keyPath = @"transform.scale";
	scaleAnimation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, timingFunction, timingFunction, nil];
	scaleAnimation.keyTimes = [NSArray arrayWithObjects:@0 , @0.25, @0.5, @0.75, @1, nil];
	scaleAnimation.values = [NSArray arrayWithObjects:@1, @0.5, @1, @0.5, @1, nil];
	scaleAnimation.duration = duration;
	
	// Translate Animation
	CAKeyframeAnimation *translateAnimation = [[CAKeyframeAnimation alloc] init];
	
	translateAnimation.keyPath = @"transform.translation";
	translateAnimation.keyTimes = scaleAnimation.keyTimes;
	translateAnimation.timingFunctions = scaleAnimation.timingFunctions;
	translateAnimation.values = [NSArray arrayWithObjects:
								 [NSValue valueWithCGSize:CGSizeMake(0, 0)],
								 [NSValue valueWithCGSize:CGSizeMake(deltaX, 0)],
								 [NSValue valueWithCGSize:CGSizeMake(deltaX, deltaY)],
								 [NSValue valueWithCGSize:CGSizeMake(0, deltaY)],
								 [NSValue valueWithCGSize:CGSizeMake(0, 0)], nil];
	translateAnimation.duration = duration;

	// Rotate Animation
	CAKeyframeAnimation *rotateAnimation = [[CAKeyframeAnimation alloc] init];
	
	rotateAnimation.keyPath = @"transform.rotation.z";
	rotateAnimation.timingFunctions = scaleAnimation.timingFunctions;
	rotateAnimation.keyTimes = scaleAnimation.keyTimes;
	rotateAnimation.duration = duration;
	rotateAnimation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithDouble:M_PI_2], [NSNumber numberWithDouble:-M_PI], [NSNumber numberWithDouble:(-1.5 * M_PI)], [NSNumber numberWithDouble:(-2 * M_PI)], nil];

	// Animation
	CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
	
	animation.animations = [NSArray arrayWithObjects:scaleAnimation, translateAnimation, rotateAnimation, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Draw Squares
	for (int i = 0; i < 2; i++)
	{
		CALayer *square = [WJActivityIndicatorShape createLayerWithShape:Rectangle Size:CGSizeMake(squareSize, squareSize) Color:color];
		CGRect frame = CGRectMake(x, y, squareSize, squareSize);
		
		animation.beginTime = beginTime + [[beginTimes objectAtIndex:i]floatValue];
		
		square.frame = frame;
		[square addAnimation:animation forKey:@"animation"];
		[layer addSublayer:square];
	}
}


@end
