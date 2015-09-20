//
//  WJAIAnimationLineScaleParty.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationLineScaleParty.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationLineScaleParty

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float lineSize = size.width / 7;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	NSArray *durations = [NSArray arrayWithObjects:@1.26, @0.43, @1.01, @0.73, nil];
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0.77, @0.29, @0.28, @0.74, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];

	// Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform.scale";
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	animation.keyTimes = [NSArray arrayWithObjects:@0 , @0.5, @1, nil];
	animation.values = [NSArray arrayWithObjects:@1, @0.5, @1, nil];
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw Lines
	for (int i = 0; i < 4; i++)
	{
		CALayer *line = [WJActivityIndicatorShape createLayerWithShape:Line Size:CGSizeMake(lineSize, size.height) Color:color];
		CGRect frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, size.height);
		
		animation.beginTime = beginTime + [[beginTimes objectAtIndex:i]floatValue];
		animation.duration = [[durations objectAtIndex:i] floatValue];
		
		line.frame = frame;
		[line addAnimation:animation forKey:@"animation"];
		[layer addSublayer:line];
	}
}


@end
