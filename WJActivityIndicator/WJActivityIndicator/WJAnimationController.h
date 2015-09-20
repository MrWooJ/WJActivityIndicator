//
//  WJAnimationDelegate.h
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WJActivityIndicatorView.h"

@protocol AnimationDelegate <NSObject>

@optional

- (void)setUpAnimationInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color;

@end

@interface WJAnimationController : NSObject

@property (nonatomic, strong) id <AnimationDelegate> delegate;

- (void)setUpAnimationForDelegateInLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)color Type:(WJAITypes)type;

@end
