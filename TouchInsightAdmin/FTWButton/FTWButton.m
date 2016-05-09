//
//  FTWButton.h
//  FTW
//
//  Created by Soroush Khanlou on 1/26/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//


#import "FTWButton.h"
#import "SKInnerShadowLayer.h"
#import "UIColor+CreateMethods.h"


@interface FTWButton()

@property (strong, nonatomic) SKInnerShadowLayer *backgroundLayer;
@property (strong, nonatomic) CAGradientLayer *borderLayer;

@property (strong, nonatomic) UIImageView *normalIcon;
@property (strong, nonatomic) UIImageView *selectedIcon;
@property (strong, nonatomic) UIImageView *highlightedIcon;

@property (strong, nonatomic) UIImageView *imgLine;
@property (strong, nonatomic) UIImageView *imgLineSelected;
@property (strong, nonatomic) UIImageView *imgLineHighlighted;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *selectedLabel;
@property (strong, nonatomic) NSMutableDictionary *texts;

@property (strong, nonatomic) NSMutableDictionary *textColors;
@property (strong, nonatomic) NSMutableDictionary *textShadowColors;
@property (strong, nonatomic) NSMutableDictionary *textShadowOffsets;

@property (strong, nonatomic) NSMutableDictionary *borderWidths;
@property (strong, nonatomic) NSMutableDictionary *borderGradients;

@property (strong, nonatomic) NSMutableDictionary *cornerRadii;

@property (strong, nonatomic) NSMutableDictionary *gradients;
@property (strong, nonatomic) NSMutableDictionary *frames;

@property (strong, nonatomic) NSMutableDictionary *shadowColors;
@property (strong, nonatomic) NSMutableDictionary *shadowOffsets;
@property (strong, nonatomic) NSMutableDictionary *shadowRadii;
@property (strong, nonatomic) NSMutableDictionary *shadowOpacities;

@property (strong, nonatomic) NSMutableDictionary *innerShadowColors;
@property (strong, nonatomic) NSMutableDictionary *innerShadowOffsets;
@property (strong, nonatomic) NSMutableDictionary *innerShadowRadii;

@property (strong, nonatomic) NSMutableDictionary *icons;


- (id) getValueFromDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState;
- (void) setValue:(id)value inDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState;


- (void) configureViewForControlState:(UIControlState)controlState;
- (void) configureLayerPropertiesForControlState:(UIControlState)controlState;
- (void) configureViewPropertiesForControlState:(UIControlState)controlState;
- (UIControlState) currentControlState;

- (void) commonInit;

@end

@implementation FTWButton

@synthesize borderLayer, backgroundLayer;
@synthesize normalIcon, selectedIcon, highlightedIcon;
@synthesize label, selectedLabel;
@synthesize texts;
@synthesize textColors, textShadowColors, textShadowOffsets, textAlignment;
@synthesize borderWidths, borderGradients, cornerRadii;
@synthesize gradients, frames;
@synthesize shadowColors, shadowOffsets, shadowRadii, shadowOpacities;
@synthesize innerShadowColors, innerShadowOffsets, innerShadowRadii;
@synthesize icons;
@synthesize iconAlignment, iconPlacement;
@synthesize imgLine, imgLineSelected, imgLineHighlighted;

#pragma mark - init methods

- (id) init {
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
		self.frame = frame;
	}
	return self;
}


- (void) commonInit {
	self.backgroundColor = [UIColor clearColor];
	
	self.label = [[UILabel alloc] init];
	label.font = [UIFont boldSystemFontOfSize:12.0f];
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor colorWithRed:107.0f/255.0f green:107.0f/255.0f blue:107.0f/255.0f alpha:0.5f];
	label.shadowOffset = CGSizeMake(0, 1);
	label.backgroundColor = [UIColor clearColor];
	[self addSubview:label];
	
	self.selectedLabel = [[UILabel alloc] init];
    selectedLabel.font = [UIFont boldSystemFontOfSize:12.0f];
	selectedLabel.textColor = [UIColor whiteColor];
	selectedLabel.shadowColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.3f];
	selectedLabel.shadowOffset = CGSizeMake(0, 1);
	selectedLabel.backgroundColor = [UIColor clearColor];
	selectedLabel.alpha = 0;
	[self addSubview:selectedLabel];
    
    
    //self.viewLine = [[UIView alloc] init];
    // @synthesize imgLine, imgLineSelected, imgLineHighlighted;
    
    
    imgLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgLineSelected = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgLineHighlighted = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    imgLine.contentMode = UIViewContentModeScaleToFill;
    imgLineSelected.contentMode = imgLine.contentMode;
    imgLineHighlighted.contentMode = imgLine.contentMode;
    
    imgLine.image = [UIImage imageNamed:@"loginBtnLine"];
    imgLineSelected.image = [UIImage imageNamed:@"loginBtnLine"];
    imgLineHighlighted.image = [UIImage imageNamed:@"loginBtnLine"];
    
    imgLineSelected.alpha = 0.5;
    imgLineHighlighted.alpha = 0.5;
    
    [self addSubview:imgLine];
    [self addSubview:imgLineSelected];
    [self addSubview:imgLineHighlighted];
    
    
	
	normalIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
	selectedIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    highlightedIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    
	normalIcon.contentMode = UIViewContentModeScaleAspectFit;
	selectedIcon.contentMode = normalIcon.contentMode;
    highlightedIcon.contentMode = normalIcon.contentMode;
    
	
	label.lineBreakMode = NSLineBreakByClipping;
	selectedLabel.lineBreakMode = NSLineBreakByClipping;
	
    
    [self addSubview:normalIcon];
	[self addSubview:selectedIcon];
    [self addSubview:highlightedIcon];
    
	
	backgroundLayer = [SKInnerShadowLayer layer];
	[self.layer insertSublayer:backgroundLayer atIndex:0];
	//	backgroundLayer.delegate = self;
	
	borderLayer = [CAGradientLayer layer];
	[self.layer insertSublayer:borderLayer atIndex:0];
	//	borderLayer.delegate = self;
	
	
	
	gradients = [NSMutableDictionary new];
	borderGradients = [NSMutableDictionary new];
	
	borderWidths = [NSMutableDictionary new];
	cornerRadii = [NSMutableDictionary new];
	
	shadowRadii = [NSMutableDictionary new];
	shadowOffsets = [NSMutableDictionary new];
	shadowColors = [NSMutableDictionary new];
	shadowOpacities = [NSMutableDictionary new];
	
	innerShadowOffsets = [NSMutableDictionary new];
	innerShadowColors = [NSMutableDictionary new];
	innerShadowRadii = [NSMutableDictionary new];
	
	textColors = [NSMutableDictionary new];
	textShadowOffsets = [NSMutableDictionary new];
	textShadowColors = [NSMutableDictionary new];
	
	frames = [NSMutableDictionary new];
	texts = [NSMutableDictionary new];
	icons = [NSMutableDictionary new];
	
	self.textAlignment = NSTextAlignmentCenter;
	[self setFont:[UIFont boldSystemFontOfSize:15.0f]];
	[self setCornerRadius:3.0f forControlState:UIControlStateNormal];
}


#pragma mark - layout

- (void) layoutSubviews {
	[super layoutSubviews];
	NSInteger horizontalPadding = 7;
	NSInteger verticalPadding = 6;

    NSString *text = [self textForControlState:self.state];
    UIFont *font = self.state == UIControlStateNormal ? label.font : selectedLabel.font;
    CGSize textSize = [self sizeOfText:text font:font];

	NSInteger imageSize = 0;
	if (normalIcon.image != nil) {
		imageSize = MAX(normalIcon.image.size.height, normalIcon.image.size.width);
		NSInteger padding = (self.frame.size.height - imageSize)/2;
        horizontalPadding = MAX(5, padding);
		verticalPadding = padding;

        CGFloat iconX = 0;
        CGFloat iconY = verticalPadding;

        switch (iconPlacement) {
            case FTWButtonIconPlacementTight:
                switch (iconAlignment) {
                    case FTWButtonIconAlignmentLeft:
                        if (textSize.width > 0) {
                            iconX = CGRectGetMidX(self.bounds) - textSize.width/2.0 - horizontalPadding - imageSize;
                        } else {
                            iconX = CGRectGetMidX(self.bounds) - imageSize/2.0;
                        }
                        break;
                    case FTWButtonIconAlignmentRight:
                        if (textSize.width > 0) {
                            iconX = CGRectGetMidX(self.bounds) + textSize.width/2.0 + horizontalPadding;
                        } else {
                            iconX = CGRectGetMidX(self.bounds) - imageSize/2.0;
                        }
                        break;
                }
                break;

            case FTWButtonIconPlacementEdge:
                switch (iconAlignment) {
                    case FTWButtonIconAlignmentLeft:
                        iconX = horizontalPadding + 2;
                        break;
                    case FTWButtonIconAlignmentRight:
                        iconX = CGRectGetWidth(self.bounds) - imageSize - horizontalPadding + 2;
                        break;
                }
                break;
        }

		normalIcon.layer.frame = CGRectMake(iconX, iconY, ((45 - horizontalPadding *2)-9), self.frame.size.height - verticalPadding*2);
		selectedIcon.layer.frame = normalIcon.layer.frame;
        highlightedIcon.layer.frame = normalIcon.layer.frame;
		imageSize += horizontalPadding;
        
        
        imgLine.layer.frame = CGRectMake(38, 0, 2 , self.frame.size.height);
        
	}

    CGRect labelRect = self.bounds;

    if (normalIcon != nil && textAlignment != NSTextAlignmentCenter) {
      labelRect = CGRectMake(horizontalPadding + imageSize + 18, verticalPadding, self.frame.size.width - horizontalPadding*2 - imageSize, self.frame.size.height - verticalPadding*2);
        
        
    }

    label.frame = selectedLabel.frame = labelRect;
}

- (CGSize)sizeOfText:(NSString *)text font:(UIFont *)font {
    CGSize textSize = CGSizeZero;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    if (font) {
        textSize = [text sizeWithAttributes:@{ NSFontAttributeName: font }];
    }
#else
    textSize = [text sizeWithFont:font];
#endif
    return [self integralSize:textSize];
}

- (CGSize)integralSize:(CGSize)size {
    CGRect rect = { CGPointZero, size };
    rect = CGRectIntegral(rect);
    return rect.size;
}

- (void) setFrame:(CGRect)aFrame {
	[self setFrame:aFrame forControlState:UIControlStateNormal];
	[self configureViewForControlState:[self currentControlState]];
}

- (void) setFrameInternal:(CGRect)aFrame {
	[super setFrame:aFrame];
	
}

- (void) setTextAlignment:(NSTextAlignment)newTextAlignment {
    textAlignment = newTextAlignment;
	label.textAlignment = newTextAlignment;
	selectedLabel.textAlignment = newTextAlignment;
    [self setNeedsLayout];
}

- (NSTextAlignment) textAlignment {
	return label.textAlignment;
}

- (void) setFont:(UIFont *)font {
	label.font = font;
	selectedLabel.font = font;
}

- (UIFont*) font {
	return label.font;
}


- (void) setSelected:(BOOL)selected {
	if (selected != self.selected) {
		super.selected = selected;
		[self setSelected:selected animated:YES];
	}
}


- (void) setHighlighted:(BOOL)highlighted {
	if (highlighted != self.highlighted) {
		super.highlighted = highlighted;
		[self setHighlighted:highlighted animated:YES];
	}
}

- (void) setEnabled:(BOOL)newEnabled {
	[super setEnabled:newEnabled];
	[self configureViewForControlState:[self currentControlState]];
}

- (void) setSelected:(BOOL)newSelected animated:(BOOL)animated {
	UIControlState controlState = [self currentControlState];
	if (animated) {
		NSTimeInterval duration = 0.2;
		
		[CATransaction begin];
		[CATransaction setAnimationDuration:duration];
		[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
		[self configureLayerPropertiesForControlState:controlState];
		[CATransaction commit];
		
		[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseInOut animations:^{
			[self configureViewPropertiesForControlState:controlState];
		} completion:^(BOOL finished) { }];
	} else {
		[self configureViewForControlState:controlState];
	}
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	UIControlState controlState = [self currentControlState];
	if (animated) {
		CGFloat duration = 0.15f;
		
		[CATransaction begin];
		[CATransaction setAnimationDuration:duration];
		[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
		[self configureLayerPropertiesForControlState:controlState];
		[CATransaction commit];
		
		[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseInOut animations:^{
			[self configureViewPropertiesForControlState:controlState];
		} completion:^(BOOL finished) { }];
	} else {
		[self configureViewForControlState:controlState];
	}
}


- (void) configureViewForControlState:(UIControlState)controlState {
	[self configureLayerPropertiesForControlState:controlState];
	[self configureViewPropertiesForControlState:controlState];
}

- (void) configureLayerPropertiesForControlState:(UIControlState)controlState {
	//rename layers to ease readability
	SKInnerShadowLayer *innerShadowLayer = backgroundLayer;
	CALayer *dropShadowLayer = self.layer;
	
	
	//set background colors and gradients
	backgroundLayer.colors =  [self colorsForControlState:controlState];
	//	backgroundLayer.backgroundColor = [self backgroundColorForControlState:controlState].CGColor;
	
	//set border widths, colors, and gradients
	if ([self borderWidthForControlState:controlState] > 0) {
		if ([self borderColorsForControlState:controlState]) {
			borderLayer.colors = [self borderColorsForControlState:controlState];
			borderLayer.backgroundColor = [UIColor clearColor].CGColor;
		} else {
			if ([self borderColorsForControlState:controlState]) {
				borderLayer.colors = [self borderColorsForControlState:controlState];
			} else {
				borderLayer.colors = [self colorsForControlState:controlState];
			}
		}
	}
	
	//set corner radii appropriately
	CGFloat cornerRadiusForControlState = [self cornerRadiusForControlState:[self currentControlState]];
	backgroundLayer.cornerRadius = cornerRadiusForControlState - [self borderWidthForControlState:[self currentControlState]];
	backgroundLayer.cornerRadius = MAX(0, backgroundLayer.cornerRadius);
	borderLayer.cornerRadius = cornerRadiusForControlState;
	
	//add drop shadow
	if ([self shadowColorForControlState:controlState]) {
		dropShadowLayer.shadowColor = [self shadowColorForControlState:controlState].CGColor;
		if ([self shadowOpacityForControlState:controlState]) {
			dropShadowLayer.shadowOpacity = [self shadowOpacityForControlState:controlState];
		} else {
			dropShadowLayer.shadowOpacity = 0.0f;
		}
	}
    
	dropShadowLayer.shadowOffset = [self shadowOffsetForControlState:controlState];
	dropShadowLayer.shadowRadius = [self shadowRadiusForControlState:controlState];
	
	
	//add inner shadow
	if ([self innerShadowColorForControlState:controlState]) {
		innerShadowLayer.innerShadowColor = [self innerShadowColorForControlState:controlState].CGColor;
		innerShadowLayer.innerShadowOpacity = 1.0f;
	}
	innerShadowLayer.innerShadowOffset = [self innerShadowOffsetForControlState:controlState];
	innerShadowLayer.innerShadowRadius = [self innerShadowRadiusForControlState:controlState];
	
	CGFloat borderWidth = [self borderWidthForControlState:controlState];
	CGRect rectForState = [self frameForControlState:controlState];
	borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(rectForState), CGRectGetHeight(rectForState));
	backgroundLayer.frame = CGRectMake(
								0 + borderWidth,
								0 + borderWidth,
								CGRectGetWidth(rectForState) - borderWidth*2,
								CGRectGetHeight(rectForState) - borderWidth*2
								);
	
	
}

- (void) configureViewPropertiesForControlState:(UIControlState)controlState {
	[self setFrameInternal:[self frameForControlState:controlState]];
	[self layoutSubviews];
	
	//set text shadow
	UILabel *labelForControlState = label;
	if (controlState & UIControlStateSelected) {
		labelForControlState = selectedLabel;
	}
	labelForControlState.shadowColor = [self textShadowColorForControlState:controlState];
	labelForControlState.shadowOffset = [self textShadowOffsetForControlState:controlState];
	if ([self textColorForControlState:controlState]) {
		labelForControlState.textColor = [self textColorForControlState:controlState];
	}
	
	CGFloat alpha = 1.0f;
    CGFloat alphaHighlight = 0.0f;
	
	//show the selected icon and label, if necessary
	if (self.selected) {
		alpha = 0.0f;
	}
    if (self.highlighted) {
        alphaHighlight = 1.0f;
    }
	label.alpha = alpha;
	normalIcon.alpha = alpha - alphaHighlight;
	selectedIcon.alpha = 1.0f - alpha;
	selectedLabel.alpha = 1.0f - alpha;
    highlightedIcon.alpha = alphaHighlight;
    
    imgLine.alpha = 1.0f;
    imgLineSelected.alpha = 0.4f;
    imgLineHighlighted.alpha = 0.4f;
}


- (UIControlState) currentControlState {
	UIControlState controlState = UIControlStateNormal;
	if (self.selected) {
		controlState += UIControlStateSelected;
	}
	if (self.highlighted) {
		controlState += UIControlStateHighlighted;
	}
	if (!self.enabled) {
		controlState += UIControlStateDisabled;
	}
	return controlState;
}



#pragma mark - default setter and getter

- (void) setValue:(id)value inDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState {
	if (value) {
		[dictionary setValue:value forKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	} else {
		[dictionary removeObjectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	}
	[self configureViewForControlState:[self currentControlState]];
}

- (id) getValueFromDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState {
	if ([dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]]) {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	}
	
	
	if ((controlState & UIControlStateSelected) && [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateSelected]]) {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateSelected]];
	} else if ((controlState & UIControlStateHighlighted) && [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateHighlighted]]) {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateHighlighted]];
	} else {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateNormal]];
	}
}




#pragma mark -  setters and getters

- (void) setTextColor:(UIColor *)newTextColor forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		label.textColor = newTextColor;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.textColor = newTextColor;
	}
	[textColors setValue:newTextColor forKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	[self setValue:newTextColor inDictionary:textColors forControlState:controlState];
}

- (UIColor*) textColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:textColors forControlState:controlState];
}

- (void) setBorderWidth:(CGFloat)borderWidth forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:borderWidth] inDictionary:borderWidths forControlState:controlState];
}

- (CGFloat) borderWidthForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:borderWidths forControlState:controlState] floatValue];
}

- (void) setCornerRadius:(CGFloat)cornerRadius forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:cornerRadius] inDictionary:cornerRadii forControlState:controlState];
}

- (CGFloat) cornerRadiusForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:cornerRadii forControlState:controlState] floatValue];
}


- (void) setTextShadowColor:(UIColor *)newTextShadowColor forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		label.shadowColor = newTextShadowColor;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.shadowColor = newTextShadowColor;
	}
	if (controlState & UIControlStateDisabled && [self currentControlState] & UIControlStateDisabled) {
		label.shadowColor = newTextShadowColor; //this isn't ideal
	}
	[self setValue:newTextShadowColor inDictionary:textShadowColors forControlState:controlState];
}

- (UIColor*) textShadowColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:textShadowColors forControlState:controlState];
}



- (void) setTextShadowOffset:(CGSize)textShadowOffset forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		label.shadowOffset = textShadowOffset;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.shadowOffset = textShadowOffset;
	}
	[self setValue:[NSValue valueWithCGSize:textShadowOffset] inDictionary:textShadowOffsets forControlState:controlState];
}

- (CGSize) textShadowOffsetForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:textShadowOffsets forControlState:controlState] CGSizeValue];
}


- (void) setText:(NSString*)text forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		if (selectedLabel.text == nil || selectedLabel.text.length == 0 || [selectedLabel.text isEqualToString:label.text]) {
			selectedLabel.text = text;
		}
		label.text = text;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.text = text;
	}
	[self setValue:text inDictionary:texts forControlState:controlState];
}

- (NSString*) textForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:texts forControlState:controlState];
}

- (void) setFrame:(CGRect)frame forControlState:(UIControlState)controlState {
	if (frames.allKeys.count == 0) {
		[self setFrameInternal:frame];
	}
	[self setValue:[NSValue valueWithCGRect:frame] inDictionary:frames forControlState:controlState];
	[self configureViewForControlState:[self currentControlState]];
}

- (CGRect) frameForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:frames forControlState:controlState] CGRectValue];
}


#pragma mark drop shadow

- (void) setShadowColor:(UIColor*)shadowColor forControlState:(UIControlState)controlState {
	[self setValue:shadowColor inDictionary:shadowColors forControlState:controlState];
}

- (UIColor*) shadowColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:shadowColors forControlState:controlState];
}

- (void) setShadowOffset:(CGSize)shadowOffset forControlState:(UIControlState)controlState {
	[self setValue:[NSValue valueWithCGSize:shadowOffset] inDictionary:shadowOffsets forControlState:controlState];
}

- (CGSize) shadowOffsetForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:shadowOffsets forControlState:controlState] CGSizeValue];
}

- (void) setShadowRadius:(CGFloat)shadowRadius forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:shadowRadius] inDictionary:shadowRadii forControlState:controlState];
}

- (CGFloat) shadowRadiusForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:shadowRadii forControlState:controlState] floatValue];
}

- (void) setShadowOpacity:(CGFloat)shadowOpacity forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:shadowOpacity] inDictionary:shadowOpacities forControlState:controlState];
}

- (CGFloat) shadowOpacityForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:shadowOpacities forControlState:controlState] floatValue];
}


#pragma mark inner shadow

- (void) setInnerShadowColor:(UIColor*)shadowColor forControlState:(UIControlState)controlState {
    [self setValue:shadowColor inDictionary:innerShadowColors forControlState:controlState];
}


- (UIColor*) innerShadowColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:innerShadowColors forControlState:controlState];
}

- (void) setInnerShadowOffset:(CGSize)shadowOffset forControlState:(UIControlState)controlState {
	[self setValue:[NSValue valueWithCGSize:shadowOffset] inDictionary:innerShadowOffsets forControlState:controlState];
}

- (CGSize) innerShadowOffsetForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:innerShadowOffsets forControlState:controlState] CGSizeValue];
}

- (void) setInnerShadowRadius:(CGFloat)shadowRadius forControlState:(UIControlState)controlState {
	[innerShadowRadii setValue:[NSNumber numberWithFloat:shadowRadius] forKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	[self setValue:[NSNumber numberWithFloat:shadowRadius] inDictionary:innerShadowRadii forControlState:controlState];
}

- (CGFloat) innerShadowRadiusForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:innerShadowRadii forControlState:controlState] floatValue];
}

#pragma mark images

- (void) setIcon:(UIImage*)icon forControlState:(UIControlState)controlState {
    
    //CGRect btnRect = CGRectMake(0, 0, 10, 22);
    
    
    normalIcon.image = icon;
    
    
    if (controlState == UIControlStateNormal) {
        normalIcon.image = icon;
    }
    if (controlState & UIControlStateSelected) {
        selectedIcon.image = icon;
        selectedIcon.alpha = 0.5;
    }
    if (controlState & UIControlStateHighlighted) {
        highlightedIcon.image = icon;
        highlightedIcon.alpha = 0.5;
    }
    
    
    [self setValue:icon inDictionary:icons forControlState:controlState];
    [self setNeedsLayout];
}

- (void) setLine:(NSString*)icon forControlState:(UIControlState)controlState {
    if (controlState == UIControlStateNormal) {
        imgLine.image = [UIImage imageNamed:icon];
    }
    if (controlState & UIControlStateSelected) {
        imgLineSelected.image = [UIImage imageNamed:icon];
        imgLineSelected.alpha = 0.5;
    }
    if (controlState & UIControlStateHighlighted) {
        imgLineHighlighted.image = [UIImage imageNamed:icon];
        imgLineHighlighted.alpha = 0.5;
    }
    [self setValue:icon inDictionary:icons forControlState:controlState];
    [self setNeedsLayout];
}

- (UIImage*) iconForControlState:(UIControlState)controlState {
    return [self getValueFromDictionary:icons forControlState:controlState];
}
- (UIImage*) lineForControlState:(UIControlState)controlState {
    return [self getValueFromDictionary:icons forControlState:controlState];
}


#pragma mark background colors

- (void) setBackgroundColor:(UIColor*)color forControlState:(UIControlState)controlState {
	[self setValue:@[ [color copy], [color copy] ] inDictionary:gradients forControlState:controlState];
}

- (void) setColors:(NSArray*)colors forControlState:(UIControlState)controlState {
	[self setValue:colors inDictionary:gradients forControlState:controlState];
}

- (NSArray*) colorsForControlState:(UIControlState)controlState {
	NSArray *colors = [self getValueFromDictionary:gradients forControlState:controlState];
	if (!colors) {
		return nil;
	}
	
	NSMutableArray *mutableColors = [NSMutableArray new];
	NSInteger numberOfColors = colors.count;
	for (NSInteger i = 0; i < numberOfColors; i++) {
		id color = [colors objectAtIndex:i];
		if ([color isKindOfClass:[UIColor class]]) {
			UIColor *theColor = (UIColor*) color;
			[mutableColors addObject:(id)theColor.CGColor];
		}
	}
	return [mutableColors copy];
}

- (void) setBorderColors:(NSArray*)borderColor forControlState:(UIControlState)controlState {
	[self setValue:borderColor inDictionary:borderGradients forControlState:controlState];
}

- (NSArray*) borderColorsForControlState:(UIControlState)controlState {
	NSArray *colors = [self getValueFromDictionary:borderGradients forControlState:controlState];
	if (!colors) {
		return nil;
	}
	NSMutableArray *mutableColors = [NSMutableArray new];
	NSInteger numberOfColors = colors.count;
	for (NSInteger i = 0; i < numberOfColors; i++) {
		id color = [colors objectAtIndex:i];
		if ([color isKindOfClass:[UIColor class]]) {
			UIColor *theColor = (UIColor*) color;
			[mutableColors addObject:(id)theColor.CGColor];
		}
	}
	return [mutableColors copy];
}


- (void) setBorderColor:(UIColor*)borderColor forControlState:(UIControlState)controlState {
	[self setValue:@[[borderColor copy], [borderColor copy]] inDictionary:borderGradients forControlState:controlState];
}

#pragma mark - built in styles

/*
- (void) addBlueStyleForState:(UIControlState)state {
   
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#6898fe" alpha:1.0],
                     [UIColor colorWithHex:@"#0472bd" alpha:1.0],
                     nil] forControlState:state];

    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setShadowColor:[UIColor colorWithHex:@"#000000" alpha:1.0] forControlState:UIControlStateNormal];
    [self setShadowOffset:CGSizeMake(5, 5) forControlState:UIControlStateNormal];
    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateHighlighted];
    [self setShadowColor:[UIColor colorWithHex:@"#72bd04" alpha:1.0] forControlState:UIControlStateHighlighted];
    [self setShadowOffset:CGSizeMake(5, 5) forControlState:UIControlStateHighlighted];
   
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#e6e6e6" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                            [UIColor colorWithHex:@"#6898fe" alpha:1.0],
                            [UIColor colorWithHex:@"#075f99" alpha:1.0],
                            nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                            [UIColor colorWithHex:@"#80a6fb" alpha:1.0],
                            [UIColor colorWithHex:@"#063971" alpha:1.0],
                            nil] forControlState:UIControlStateHighlighted];
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#4a8dea" alpha:1.0],
                         [UIColor colorWithHex:@"#04549f" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        [self setInnerShadowColor:[UIColor colorWithHex:@"#333333" alpha:1.0] forControlState:highlightedState];
    }
    
}
*/


- (void) addBlueStyleForState:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#0071BB" alpha:1.0],
                     [UIColor colorWithHex:@"#0071BB" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#0071BB" alpha:1.0] ,
                           [UIColor colorWithHex:@"#0071BB" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#005892" alpha:1.0] ,
                           [UIColor colorWithHex:@"#005892" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:3.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#005892" alpha:1.0],
                         [UIColor colorWithHex:@"#005892" alpha:1.0],
                         nil] forControlState:highlightedState];
    }
    
}

/*
- (void) addGrayStyleForState:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#f1f1f1" alpha:1.0],
                     [UIColor colorWithHex:@"#b4b4b4" alpha:1.0],
                     nil] forControlState:state];
    
    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setShadowColor:[UIColor colorWithHex:@"#000000" alpha:1.0] forControlState:UIControlStateNormal];
    [self setShadowOffset:CGSizeMake(5, 5) forControlState:UIControlStateNormal];
    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateHighlighted];
    [self setShadowColor:[UIColor colorWithHex:@"#72bd04" alpha:1.0] forControlState:UIControlStateHighlighted];
    [self setShadowOffset:CGSizeMake(5, 5) forControlState:UIControlStateHighlighted];
    
    
    
    [self setTextColor:[UIColor colorWithHex:@"#666666" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#4b4b4b" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#f2f2f2" alpha:1.0] ,
                           [UIColor colorWithHex:@"#7c7c7c" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#d3d3d3" alpha:1.0] ,
                           [UIColor colorWithHex:@"#505050" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#b7b7b7" alpha:1.0],
                         [UIColor colorWithHex:@"#8a8a8a" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        [self setInnerShadowColor:[UIColor colorWithHex:@"#333333" alpha:1.0] forControlState:highlightedState];
    }
    
}*/

- (void) addGrayStyleForState:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#b3b3b3" alpha:1.0],
                     [UIColor colorWithHex:@"#b3b3b3" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#b3b3b3" alpha:1.0] ,
                           [UIColor colorWithHex:@"#b3b3b3" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#8c8c8c" alpha:1.0] ,
                           [UIColor colorWithHex:@"#8c8c8c" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:3.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#8c8c8c" alpha:1.0],
                         [UIColor colorWithHex:@"#8c8c8c" alpha:1.0],
                         nil] forControlState:highlightedState];
    }
    
}

/*
- (void) addOrangeStyleForState:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#fcdb17" alpha:1.0],
                     [UIColor colorWithHex:@"#f99c1c" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#fcdb17" alpha:1.0] ,
                           [UIColor colorWithHex:@"#de8914" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#fce13d" alpha:1.0] ,
                           [UIColor colorWithHex:@"#af6b0c" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#edcd0e" alpha:1.0],
                         [UIColor colorWithHex:@"#ee900c" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        [self setInnerShadowColor:[UIColor colorWithHex:@"#666666" alpha:1.0] forControlState:highlightedState];
    }
    
}
*/



- (void) addOrangeStyleForState:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#fbb600" alpha:1.0],
                     [UIColor colorWithHex:@"#fbb600" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#fbb600" alpha:1.0] ,
                           [UIColor colorWithHex:@"#fbb600" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#d58c00" alpha:1.0] ,
                           [UIColor colorWithHex:@"#d58c00" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:3.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#d58c00" alpha:1.0],
                         [UIColor colorWithHex:@"#d58c00" alpha:1.0],
                         nil] forControlState:highlightedState];
    }
    
}

- (void) addBlackStyleForState:(UIControlState)state{
    
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#787a77" alpha:1.0],
                     [UIColor colorWithHex:@"#4b4b40" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#b2b2af" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#787a76" alpha:1.0] ,
                           [UIColor colorWithHex:@"#2c2c28" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#878886" alpha:1.0] ,
                           [UIColor colorWithHex:@"#1d1d1a" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#666666" alpha:1.0],
                         [UIColor colorWithHex:@"#2e2e2a" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        [self setInnerShadowColor:[UIColor colorWithHex:@"#666666" alpha:1.0] forControlState:highlightedState];
    }
    
    
}
- (void) addRedStyleForState:(UIControlState)state{
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#d60505" alpha:1.0],
                     [UIColor colorWithHex:@"#a00808" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#d70505" alpha:1.0] ,
                           [UIColor colorWithHex:@"#8b0707" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#f30a0a" alpha:1.0] ,
                           [UIColor colorWithHex:@"#5e0303" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#c30808" alpha:1.0],
                         [UIColor colorWithHex:@"#7d0808" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        [self setInnerShadowColor:[UIColor colorWithHex:@"#666666" alpha:1.0] forControlState:highlightedState];
    }

}
/*
 
 - (void) addGreenStyleForState:(UIControlState)state{
 [self setColors:[NSArray arrayWithObjects:
 [UIColor colorWithHex:@"#5cdb19" alpha:1.0],
 [UIColor colorWithHex:@"#458e07" alpha:1.0],
 nil] forControlState:state];
 
 
 [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
 [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
 
 [self setBorderColors:[NSArray arrayWithObjects:
 [UIColor colorWithHex:@"#5cdb19" alpha:1.0] ,
 [UIColor colorWithHex:@"#387802" alpha:1.0] ,
 nil] forControlState:UIControlStateNormal];
 
 [self setBorderColors:[NSArray arrayWithObjects:
 [UIColor colorWithHex:@"#62e01f" alpha:1.0] ,
 [UIColor colorWithHex:@"#264c04" alpha:1.0] ,
 nil] forControlState:UIControlStateHighlighted];
 
 
 [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
 [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
 
 
 if (state == UIControlStateSelected || state == UIControlStateNormal) {
 UIControlState highlightedState = state | UIControlStateHighlighted;
 
 [self setColors:[NSArray arrayWithObjects:
 [UIColor colorWithHex:@"#51c611" alpha:1.0],
 [UIColor colorWithHex:@"#387206" alpha:1.0],
 nil] forControlState:highlightedState];
 
 [self setInnerShadowColor:[UIColor colorWithHex:@"#666666" alpha:1.0] forControlState:highlightedState];
 }
 }
*/

/*
 Green normal / color code : 29C019, Green click / color code :  299119
 */


- (void) addGreenStyleForState:(UIControlState)state{
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#29C019" alpha:1.0],
                     [UIColor colorWithHex:@"#29C019" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#29C019" alpha:1.0] ,
                           [UIColor colorWithHex:@"#29C019" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#299119" alpha:1.0] ,
                           [UIColor colorWithHex:@"#299119" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:3.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#299119" alpha:1.0],
                         [UIColor colorWithHex:@"#299119" alpha:1.0],
                         nil] forControlState:highlightedState];
    }
}

- (void) addWhiteStyleForState:(UIControlState)state{
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#f0f0f0" alpha:1.0],
                     [UIColor colorWithHex:@"#b3b3b3" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#333335" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#0e0e10" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#f1f1f1" alpha:1.0] ,
                           [UIColor colorWithHex:@"#939292" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#f7f7f7" alpha:1.0] ,
                           [UIColor colorWithHex:@"#5f5f5f" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#e3e3e3" alpha:1.0],
                         [UIColor colorWithHex:@"#9d9d9d" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        [self setInnerShadowColor:[UIColor colorWithHex:@"#666666" alpha:1.0] forControlState:highlightedState];
    }
}



- (void) addBlueStyleForState_bk:(UIControlState)state {
    /*
     [self setColors:[NSArray arrayWithObjects:
     [UIColor colorWithRed:104.0f/255 green:152.0f/255 blue:254.0f/255 alpha:1.0f],
     [UIColor colorWithRed:0.0f/255 green:51.0f/255 blue:191.0f/255 alpha:1.0f],
     nil] forControlState:state];
     
     
     [self setInnerShadowColor:[UIColor colorWithRed:86.0f/255 green:174.0f/255 blue:199.0f/255 alpha:1.0f] forControlState:state];
     [self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
     
     [self setShadowColor:[UIColor blackColor] forControlState:state];
     [self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
     
     [self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
     [self setTextShadowColor:[UIColor colorWithWhite:78.0f/255 alpha:1.0f] forControlState:state];
     [self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
     
     if (state == UIControlStateSelected || state == UIControlStateNormal) {
     UIControlState highlightedState = state | UIControlStateHighlighted;
     
     [self setColors:[NSArray arrayWithObjects:
     [UIColor colorWithRed:104.0f/255 green:152.0f/255 blue:254.0f/255 alpha:1.0f],
     [UIColor colorWithRed:0.0f/255 green:51.0f/255 blue:191.0f/255 alpha:1.0f],
     nil] forControlState:highlightedState];
     [self setInnerShadowColor:[UIColor colorWithRed:86.0f/255 green:174.0f/255 blue:199.0f/255 alpha:1.0f] forControlState:highlightedState];
     }
     */
    
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#6898fe" alpha:1.0],
                     [UIColor colorWithHex:@"#0472bd" alpha:1.0],
                     nil] forControlState:state];
    
    /*
     [self setInnerShadowColor:[UIColor colorWithHex:@"#191919" alpha:1.0] forControlState:state];
     [self setInnerShadowOffset:CGSizeMake(0, 5) forControlState:state];
     */
    
    /*
     [self setShadowColor:[UIColor blackColor] forControlState:state];
     [self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
     */
    
    
    /*
     [self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
     [self setTextShadowColor:[UIColor colorWithWhite:78.0f/255 alpha:1.0f] forControlState:state];
     [self setTextShadowOffset:CGSizeMake(0, 1) forControlState:state];
     */
    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setShadowColor:[UIColor colorWithHex:@"#01395e" alpha:1.0] forControlState:UIControlStateNormal];
    [self setShadowOffset:CGSizeMake(5, 5) forControlState:UIControlStateNormal];
    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateHighlighted];
    [self setShadowColor:[UIColor colorWithHex:@"#72bd04" alpha:1.0] forControlState:UIControlStateHighlighted];
    [self setShadowOffset:CGSizeMake(5, 5) forControlState:UIControlStateHighlighted];
    
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#344c7f" alpha:1.0],
                         [UIColor colorWithHex:@"#01395e" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        [self setInnerShadowColor:[UIColor colorWithHex:@"#333333" alpha:1.0] forControlState:highlightedState];
    }
    
}


/*
- (void) addBlueStyleForState:(UIControlState)state {
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithRed:2.0f/255 green:184.0f/255 blue:255.0f/255 alpha:1.0f],
                     [UIColor colorWithRed:0.0f/255 green:68.0f/255 blue:255.0f/255 alpha:1.0f],
                     nil] forControlState:state];
    
    
    [self setInnerShadowColor:[UIColor colorWithRed:108.0f/255 green:221.0f/255 blue:253.0f/255 alpha:1.0f] forControlState:state];
    [self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
    
    [self setShadowColor:[UIColor blackColor] forControlState:state];
    [self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
    
    [self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
    [self setTextShadowColor:[UIColor colorWithWhite:78.0f/255 alpha:1.0f] forControlState:state];
    [self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithRed:1.0f/255 green:150.0f/255 blue:207.0f/255 alpha:1.0f],
                         [UIColor colorWithRed:0.0f/255 green:51.0f/255 blue:191.0f/255 alpha:1.0f],
                         nil] forControlState:highlightedState];
        [self setInnerShadowColor:[UIColor colorWithRed:86.0f/255 green:174.0f/255 blue:199.0f/255 alpha:1.0f] forControlState:highlightedState];
    }
}
*/


- (void) addAlphaFavStyleForState:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#FFFFFF" alpha:0.0],
                     [UIColor colorWithHex:@"#FFFFFF" alpha:0.0],
                     nil] forControlState:state];
    
    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    //[self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:0.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:0.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#000000" alpha:0.2],
                         [UIColor colorWithHex:@"#000000" alpha:0.2],
                         nil] forControlState:highlightedState];
    }
    
}

- (void) addAlphaListStyleForState:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#FFFFFF" alpha:0.0],
                     [UIColor colorWithHex:@"#FFFFFF" alpha:0.0],
                     nil] forControlState:state];
    
    
    //[self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    //[self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:0.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:0.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#fbb500" alpha:0.5],
                         [UIColor colorWithHex:@"#fbb500" alpha:0.5],
                         nil] forControlState:highlightedState];
    }
    
}


- (void) addBtnLogin:(UIControlState)state{
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#E43237" alpha:1.0],
                     [UIColor colorWithHex:@"#D30D02" alpha:1.0],
                     nil] forControlState:state];
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#EF444F" alpha:1.0] ,
                           [UIColor colorWithHex:@"#CB1502" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#EF444F" alpha:1.0] ,
                           [UIColor colorWithHex:@"#BA1A00" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:5.0f forControlState:UIControlStateNormal];
    
    //[self setFont:[UIFont boldSystemFontOfSize:20.0f]];
    //[self setFont:[UIFont fontWithName:@"ThaiSansNeue-Regular" size:30]];
    
    //self.txtFont.font = [UIFont fontWithName:@"thaisanslite" size:40];
    
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#D30D02" alpha:1.0],
                         [UIColor colorWithHex:@"#BA1A00" alpha:1.0],
                         nil] forControlState:highlightedState];
        
        //[self setInnerShadowColor:[UIColor colorWithHex:@"#666666" alpha:1.0] forControlState:highlightedState];
    }
    
    //[self setFont:[UIFont fontWithName:@"thaisanslite" size:30]];
    
    //selectedLabel.font = [UIFont fontWithName:@"ThaiSansNeue" size:20];
    
    
    
}

//


- (void) addBtnFacebook:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#136AB0" alpha:1.0],
                     [UIColor colorWithHex:@"#0D579E" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#247FC1" alpha:1.0] ,
                           [UIColor colorWithHex:@"#0A4C9A" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#005892" alpha:1.0] ,
                           [UIColor colorWithHex:@"#0D579E" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#005892" alpha:1.0],
                         [UIColor colorWithHex:@"#005892" alpha:1.0],
                         nil] forControlState:highlightedState];
    }
    
}



- (void) addBtnLinkedin:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#1D8ECF" alpha:1.0],
                     [UIColor colorWithHex:@"#1571AC" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#3BA9DB" alpha:1.0] ,
                           [UIColor colorWithHex:@"#1E8FB8" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#1E8FB8" alpha:1.0] ,
                           [UIColor colorWithHex:@"#136BA2" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#1C8ACB" alpha:1.0],
                         [UIColor colorWithHex:@"#146FA7" alpha:1.0],
                         nil] forControlState:highlightedState];
    }
    
}



- (void) addBtnGoogle:(UIControlState)state {
    
    [self setColors:[NSArray arrayWithObjects:
                     [UIColor colorWithHex:@"#F14831" alpha:1.0],
                     [UIColor colorWithHex:@"#C43E27" alpha:1.0],
                     nil] forControlState:state];
    
    
    [self setTextColor:[UIColor colorWithHex:@"#ffffff" alpha:1.0] forControlState:UIControlStateNormal];
    [self setTextColor:[UIColor colorWithHex:@"#eeeeee" alpha:1.0] forControlState:UIControlStateHighlighted];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#E67160" alpha:1.0] ,
                           [UIColor colorWithHex:@"#CC533E" alpha:1.0] ,
                           nil] forControlState:UIControlStateNormal];
    
    [self setBorderColors:[NSArray arrayWithObjects:
                           [UIColor colorWithHex:@"#ED422C" alpha:1.0] ,
                           [UIColor colorWithHex:@"#BD3D26" alpha:1.0] ,
                           nil] forControlState:UIControlStateHighlighted];
    
    
    [self setBorderWidth:2.0f forControlState:UIControlStateNormal];
    [self setCornerRadius:4.0f forControlState:UIControlStateNormal];
    
    
    if (state == UIControlStateSelected || state == UIControlStateNormal) {
        UIControlState highlightedState = state | UIControlStateHighlighted;
        
        [self setColors:[NSArray arrayWithObjects:
                         [UIColor colorWithHex:@"#F1462D" alpha:1.0],
                         [UIColor colorWithHex:@"#C54028" alpha:1.0],
                         nil] forControlState:highlightedState];
    }
    
}


//- (void) addBtnLinkedin:(UIControlState)state;
//- (void) addBtnGoogle:(UIControlState)state;



- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    [border setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self addSubview:border];
}

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    [border setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    border.layer.cornerRadius = 4.0;
    
    
    [self addSubview:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [border setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin];
    [self addSubview:border];
}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    [border setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin];
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self addSubview:border];
}

@end
