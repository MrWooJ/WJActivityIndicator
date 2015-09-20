//
//  WJAIAnimationBallTrianglePath.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJAIAnimationBallTrianglePath.h"
#import "WJActivityIndicatorShape.h"

@implementation WJAIAnimationBallTrianglePath

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color {
	
	// Pre Initialize Values
	float circleSize = size.width / 5;
	float deltaX = size.width / 2 - circleSize / 2;
	float deltaY = size.height / 2 - circleSize / 2;
	float x = (layer.bounds.size.width - size.width) / 2;
	float y = (layer.bounds.size.height - size.height) / 2;
	CFTimeInterval duration = 2;
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	// Animation
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	
	animation.keyPath = @"transform";
	animation.keyTimes = [NSArray arrayWithObjects:@0, @0.33, @0.66, @1, nil];
	animation.timingFunctions = [NSArray arrayWithObjects:timingFunction, timingFunction, timingFunction, nil];
	animation.duration = duration;
	animation.repeatCount = HUGE;
	animation.removedOnCompletion = false;
	
	// Top-center circle
	CALayer *topCenterCircle = [WJActivityIndicatorShape createLayerWithShape:Ring Size:CGSizeMake(circleSize, circleSize) Color:color];

	NSArray *rawArray1 = [NSArray arrayWithObjects:@"{0,0}", @"{hx,fy}", @"{-hx,fy}", @"{0,0}", nil];
	[self changeAnimation:animation RawValues:rawArray1 DeltaX:deltaX DeltaY:deltaY];
	topCenterCircle.frame = CGRectMake(x + size.width / 2 - circleSize / 2, y, circleSize, circleSize);
	[topCenterCircle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:topCenterCircle];

	// Bottom-left circle
	CALayer *bottomLeftCircle = [WJActivityIndicatorShape createLayerWithShape:Ring Size:CGSizeMake(circleSize, circleSize) Color:color];
	
	NSArray *rawArray2 = [NSArray arrayWithObjects:@"{0,0}", @"{hx,-fy}", @"{fx,0}", @"{0,0}", nil];
	[self changeAnimation:animation RawValues:rawArray2 DeltaX:deltaX DeltaY:deltaY];
	bottomLeftCircle.frame = CGRectMake(x, y + size.height - circleSize, circleSize, circleSize);
	[bottomLeftCircle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:bottomLeftCircle];

	// Bottom-right circle
	CALayer *bottomRightCircle = [WJActivityIndicatorShape createLayerWithShape:Ring Size:CGSizeMake(circleSize, circleSize) Color:color];
	
	NSArray *rawArray3 = [NSArray arrayWithObjects:@"{0,0}", @"{-fx,0}", @"{-hx,-fy}", @"{0,0}", nil];
	[self changeAnimation:animation RawValues:rawArray3 DeltaX:deltaX DeltaY:deltaY];
	bottomRightCircle.frame = CGRectMake(x + size.width - circleSize, y + size.height - circleSize, circleSize, circleSize);
	[bottomRightCircle addAnimation:animation forKey:@"animation"];
	[layer addSublayer:bottomRightCircle];
}

- (CAAnimation *)changeAnimation:(CAKeyframeAnimation *)animation RawValues:(NSArray *)rawValues DeltaX:(float)deltaX DeltaY:(float)deltaY {
	
	NSMutableArray *values = [[NSMutableArray alloc]initWithCapacity:5];
	
	for (NSString *rawValue in rawValues) {
		CGPoint point = CGPointFromString([self translateString:rawValue DeltaX:deltaX DeltaY:deltaY]);
		
		[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(point.x, point.y, 0)]];
	}
	
	animation.values = values;
	
	return animation;
}

- (NSString *)translateString:(NSString *)valueString DeltaX:(float)deltaX DeltaY:(float)deltaY {
	
	NSMutableString *valueMutableString = [NSMutableString stringWithString:valueString];
	float fullDeltaX = 2 * deltaX;
	float fullDeltaY = 2 * deltaY;
	NSRange range = NSMakeRange(0, valueMutableString.length);

	[valueMutableString replaceOccurrencesOfString:@"hx" withString:[NSString stringWithFormat:@"%f",deltaX] options:NSCaseInsensitiveSearch range:range];
	range.length = valueMutableString.length;
	
	[valueMutableString replaceOccurrencesOfString:@"fx" withString:[NSString stringWithFormat:@"%f",fullDeltaX] options:NSCaseInsensitiveSearch range:range];
	range.length = valueMutableString.length;

	[valueMutableString replaceOccurrencesOfString:@"hy" withString:[NSString stringWithFormat:@"%f",deltaY] options:NSCaseInsensitiveSearch range:range];
	range.length = valueMutableString.length;

	[valueMutableString replaceOccurrencesOfString:@"fy" withString:[NSString stringWithFormat:@"%f",fullDeltaY] options:NSCaseInsensitiveSearch range:range];

	return valueMutableString;
}

@end
