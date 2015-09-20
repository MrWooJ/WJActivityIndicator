//
//  WJActivityIndicatorView.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJActivityIndicatorView.h"
#import "WJAnimationController.h"

@interface WJActivityIndicatorView ()
{
	WJAITypes	DEFAULT_TYPE;
	UIColor*	DEFAULT_COLOR;
	CGSize		DEFAULT_SIZE;
	
	BOOL animating;
	BOOL hidesWhenStopped;
}

@property (nonatomic) WJAITypes type;
@property (nonatomic) UIColor*	color;
@property (nonatomic) CGSize	size;

@end

@implementation WJActivityIndicatorView

#pragma mark - LifeCycle

- (instancetype)init {
	
	self = [super init];

	if (self) {
		
		[self setDefaultValues];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		
		[self setDefaultValues];
		
		self.type	= DEFAULT_TYPE;
		self.color	= DEFAULT_COLOR;
		self.size	= DEFAULT_SIZE;
	}
	
	return self;
}

- (void)setDefaultValues {
	
	animating = NO;
	hidesWhenStopped = NO;
	
	DEFAULT_TYPE	= Pacman;
	DEFAULT_COLOR	= [UIColor whiteColor];
	DEFAULT_SIZE	= CGSizeMake(40, 40);
}

- (void)completeWithFrame:(CGRect)frame Type:(WJAITypes)type Color:(UIColor *)color Size:(CGSize)size {
	
	[self setFrame:frame];
	self.type = type;
	self.size = size;
	self.color = color;
}

#pragma mark - Animation Setting

- (void)startAnimation {
	
	if (hidesWhenStopped && self.hidden)
		self.hidden = false;
	
	if (self.layer.sublayers == nil)
		[self setupAnimation];

	self.layer.speed = 1;
	animating = true;
}

- (void)stopAnimation {
	
	self.layer.speed = 0;
	animating = false;
	
	if (hidesWhenStopped && !self.hidden)
		self.hidden = true;
}

- (void)setupAnimation {
	
	self.layer.sublayers = nil;

	WJAnimationController *controller = [[WJAnimationController alloc]init];
	[controller setUpAnimationForDelegateInLayer:self.layer Size:self.size Color:self.color Type:self.type];
}

@end
