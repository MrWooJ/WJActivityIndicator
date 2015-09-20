//
//  WJActivityIndicatorShape.h
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM (NSInteger, WJAIShapes) {
	
	Circle					= 0,
	CircleSemi				= 1,
	Ring					= 2,
	RingTwoHalfVertical		= 3,
	RingTwoHalfHorizontal	= 4,
	RingThirdFour			= 5,
	Rectangle				= 6,
	Triangle				= 7,
	Line					= 8,
	Pacman					= 9,
	
}shape;

static const NSInteger ShapesCount = 10;

@interface WJActivityIndicatorShape : NSObject

+ (CALayer *)createLayerWithShape:(WJAIShapes)shape Size:(CGSize)size Color:(UIColor *)color;

@end
