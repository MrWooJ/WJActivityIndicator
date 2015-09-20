//
//  WJAIAnimationLineSpinFadeLoader.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationLineSpinFadeLoader.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationLineSpinFadeLoader

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float lineSpacing = 2;
	CGSize lineSize = CGSizeMake((size.width - 4 * lineSpacing) / 5, size.height / 3);
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	CFTimeInterval duration = 1.2;
	CFTimeInterval beginTime = CACurrentMediaTime();
	NSArray *beginTimes = [NSArray arrayWithObjects:@0.12, @0.24, @0.36, @0.48, @0.6, @0.72, @0.84, @0.96, nil];
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

	// Opacity Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"opacity";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.5, @1, nil];
	animation.values = [NSArray arrayWithObjects:@1, @0.3, @1, nil];
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;

	// Assign Lines
	for (int i = 0; i < 8; i++)
	{
		CALayer *line = [self lineAtAngle:(M_PI_4 * i) Size:lineSize Origin:CGPointMake(x, y) ContainerSize:size Color:color];

		animation.beginTime = beginTime + [[beginTimes objectAtIndex:i]floatValue];
		
		[line addAnimation:animation forKey:@"animation"];
		[layer addSublayer:line];
	}
}

- (CALayer *)lineAtAngle:(float)angle Size:(CGSize)size Origin:(CGPoint)origin ContainerSize:(CGSize)containerSize Color:(UIColor *)color {
	
	// Deaw Lines
	float radius = containerSize.width / 2;
	CGSize lineContainerSize = CGSizeMake(MAX(size.width, size.height), MAX(size.width, size.height));
	
	CALayer *lineContainer = [[CALayer alloc]init];
	CGRect lineContainerFrame = CGRectMake(origin.x + radius * (cos(angle) + 1) - lineContainerSize.width / 2, origin.y + radius * (sin(angle) + 1) - lineContainerSize.height / 2, lineContainerSize.width, lineContainerSize.height);
	
	CALayer *line = [WJActivityIndicatorShape createLayerWithShape:Line Size:size Color:color];
	CGRect lineFrame = CGRectMake((lineContainerSize.width - size.width) / 2, (lineContainerSize.height - size.height) / 2, size.width, size.height);
	
	lineContainer.frame = lineContainerFrame;
	line.frame = lineFrame;
	[lineContainer addSublayer:line];
	lineContainer.sublayerTransform = CATransform3DMakeRotation(M_PI_2 + angle, 0, 0, 1);
	
	return lineContainer;
}

@end
