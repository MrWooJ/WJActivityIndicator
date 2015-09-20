//
//  WJAIAnimationSemiCircleSpin.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationSemiCircleSpin.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationSemiCircleSpin

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	CFTimeInterval duration = 0.6;
	
	// Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform.rotation.z";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	animation.values = [NSArray arrayWithObjects:@0, [NSNumber numberWithDouble:M_PI], [NSNumber numberWithDouble:(2 * M_PI)], nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw Semi Circle
	CALayer *circle = [WJActivityIndicatorShape createLayerWithShape:CircleSemi Size:size Color:color];
	CGRect frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.width - size.height) / 2, size.width, size.height);
	
	circle.frame = frame;
	[circle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:circle];
}


@end
