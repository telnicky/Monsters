//
//  MSTUISliderView.m
//  Monsters
//
//  Created by travis elnicky on 1/21/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import "MSTUISliderView.h"

@implementation MSTUISliderView
{
    NSInvocation* _invocation;
    NSMethodSignature* _signature;
    UILabel* _valueLabel;
}

- (id) initWithMonster:(MSTMonster*)monster property:(NSString*)property min:(float)min max:(float)max andFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if(self == nil)
        return nil;

    NSString* setSelector = [@"set" stringByAppendingString:[property capitalizedString]];
    setSelector = [setSelector stringByAppendingString:@":"];
    
    [self setMonster:monster];
    [self setSelector:NSSelectorFromString(setSelector)];
    [self setProperty:property];
    [self setMin: min];
    [self setMax: max];
    [self buildSlider];
    _invocation = [self buildInvocation:_invocation andSignature:_signature];
    
    return self;
}

- (void) buildSlider
{
    
    // Label
    CGRect labelFrame = CGRectZero;
    labelFrame.origin.x = 10.0f;
    labelFrame.origin.y = 0.0f;
    labelFrame.size.width = [self frame].size.width * 0.2f;
    labelFrame.size.height = 20.0f;
    
    UILabel* label = [[UILabel alloc] init];
    [label setFrame:labelFrame];
    [label setText:[[self property] stringByAppendingString:@":"]];
    [label setAdjustsFontSizeToFitWidth:TRUE];
    [self addSubview:label];
    
    // Value Label
    CGRect valueLabelFrame = CGRectZero;
    valueLabelFrame.origin.x = CGRectGetMaxX(labelFrame);
    valueLabelFrame.origin.y = 0.0f;
    valueLabelFrame.size.width = [self frame].size.width * 0.10f;
    valueLabelFrame.size.height = 20.0f;
    
    _valueLabel = [[UILabel alloc] init];
    [_valueLabel setFrame:valueLabelFrame];
    [_valueLabel setText:[NSString stringWithFormat:@"%0.0f", [self min]]];
    [_valueLabel setAdjustsFontSizeToFitWidth:TRUE];
    [self addSubview:_valueLabel];
    
    // Slider
    CGRect sliderFrame = CGRectZero;
    sliderFrame.origin.x = CGRectGetMaxX(valueLabelFrame);
    sliderFrame.origin.y = 0.0f;
    sliderFrame.size.width = [self frame].size.width * 0.50f;
    sliderFrame.size.height = 20.0f;
    
    UISlider* slider = [[UISlider alloc] init];
    [slider setMinimumValue:[self min]];
    [slider setMaximumValue:[self max]];
    [slider setFrame:sliderFrame];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
}

- (NSInvocation*) buildInvocation:(NSInvocation*)invocation andSignature:(NSMethodSignature*)signature
{
    SEL theSelector = [self selector];
    signature = [MSTMonster instanceMethodSignatureForSelector:theSelector];
    invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:theSelector];
    
    [invocation setTarget:[self monster]];
    
    return invocation;
}

- (void) valueChanged:(UISlider*)slider
{
    float value = [slider value];
    [_valueLabel setText:[NSString stringWithFormat:@"%0.0f", value]];
    [_invocation setArgument:&value atIndex:2];
    [_invocation invoke];
}

@end


