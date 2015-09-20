//
//  WJActivityIndicatorShape.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJActivityIndicatorShape.h"

@implementation WJActivityIndicatorShape

+ (CALayer *)createLayerWithShape:(WJAIShapes)shape Size:(CGSize)size Color:(UIColor *)color {
	
	CAShapeLayer *layer = [[CAShapeLayer alloc] init];
	UIBezierPath *path	= [[UIBezierPath alloc] init];

	NSUInteger lineWidth = 2;
	
	switch (shape)
	{
		case Circle:
			
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:0 endAngle:(2.0 * M_PI) clockwise:false];
			layer.fillColor = color.CGColor;
			break;
			
		case CircleSemi:
			
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:(-M_PI / 6) endAngle:(-5 * M_PI / 6) clockwise:false];
			[path closePath];
			layer.fillColor = color.CGColor;
			break;
			
		case Ring:
			
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:0 endAngle:(2.0 * M_PI) clockwise:false];
			layer.fillColor = nil;
			layer.strokeColor = color.CGColor;
			layer.lineWidth = lineWidth;
			break;
			
			
		case RingTwoHalfVertical:
			
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:(-3 * M_PI_4) endAngle:(-M_PI_4) clockwise:true];
			[path moveToPoint:CGPointMake(size.width / 2 - size.width / 2 * cos(M_PI_4), size.height / 2 + size.height / 2 * sin(M_PI_4))];
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:(-5 * M_PI_4) endAngle:(-7 * M_PI_4) clockwise:false];
			layer.fillColor = nil;
			layer.strokeColor = color.CGColor;
			layer.lineWidth = lineWidth;
			break;
			
		case RingTwoHalfHorizontal:
			
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:(3 * M_PI_4) endAngle:(5 * M_PI_4) clockwise:true];
			[path moveToPoint:CGPointMake(size.width / 2 + size.width / 2 * cos(M_PI_4), size.height / 2 - size.height / 2 * sin(M_PI_4))];
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:(-M_PI_4) endAngle:(M_PI_4) clockwise:true];
			layer.fillColor = nil;
			layer.strokeColor = color.CGColor;
			layer.lineWidth = lineWidth;
			break;


		case RingThirdFour:
			
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 2.0) startAngle:(-3 * M_PI_4) endAngle:(-M_PI_4) clockwise:false];
			layer.fillColor = nil;
			layer.strokeColor = color.CGColor;
			layer.lineWidth = lineWidth;
			break;
			
		case Rectangle:
			
			[path moveToPoint:CGPointMake(0, 0)];
			[path addLineToPoint:CGPointMake(size.width, 0)];
			[path addLineToPoint:CGPointMake(size.width, size.height)];
			[path addLineToPoint:CGPointMake(0, size.height)];
			layer.fillColor = color.CGColor;
			break;
			
		case Triangle:
			
			[path moveToPoint:CGPointMake(0, size.height - (size.height / 4))];
			[path addLineToPoint:CGPointMake(size.width / 2, size.height / 2 - (size.height / 4))];
			[path addLineToPoint:CGPointMake(size.width, size.height - (size.height / 4))];
			[path closePath];
			layer.fillColor = color.CGColor;
			break;
			
		case Line:
			
			path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:(size.width / 2)];
			layer.fillColor = color.CGColor;
			break;
			
		case Pacman:
			
			[path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0)
							radius:(size.width / 4.0) startAngle:0 endAngle:(2 * M_PI) clockwise:true];
			layer.fillColor = nil;
			layer.strokeColor = color.CGColor;
			layer.lineWidth = size.width / 2;
			break;
			
		default:
			break;
	}
	
	layer.backgroundColor = nil;
	layer.path = path.CGPath;

	return layer;
}

@end
