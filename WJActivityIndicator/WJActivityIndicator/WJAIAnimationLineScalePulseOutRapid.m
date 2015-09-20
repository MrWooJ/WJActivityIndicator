//
//  WJAIAnimationLineScalePulseOutRapid.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationLineScalePulseOutRapid.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationLineScalePulseOutRapid

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float lineSize = size.width / 9;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	CFTimeInterval duration = 0.9;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0.5, @0.25, @0, @0.25, @0.5, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.11 :0.49 :0.38 :0.78];

	// Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform.scale.y";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.8, @0.9, nil];
	animation.values = [NSArray arrayWithObjects:@1, @0.3, @1, nil];
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Draw Lines
	for (int i = 0; i < 5; i++)
	{
		CALayer *line = [WJActivityIndicatorShape createLayerWithShape:Line Size:CGSizeMake(lineSize, size.height) Color:color];
		CGRect frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, size.height);
		
		animation.beginTime = beginTime + [[beginTimes objectAtIndex:i]floatValue];
		
		line.frame = frame;
		[line addAnimation:animation forKey:@"animation"];
		[layer addSublayer:line];
	}
}

@end
