//
//  MSTUISliderView.m
//  Monsters
//
//  Created by travis elnicky on 1/21/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import "MSTSliderView.h"

@implementation MSTSliderView
{
    NSInvocation* _setInvocation;
    NSInvocation* _getInvocation;
    NSMethodSignature* _setSignature;
    NSMethodSignature* _getSignature;
    UILabel* _valueLabel;
}

- (id) initWithMonster:(MSTMonster*)monster property:(NSString*)property min:(float)min max:(float)max andFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if(self == nil)
        return nil;

    NSString* getSelector = [property lowercaseString];
    NSString* setSelector = [@"set" stringByAppendingString:[property capitalizedString]];
    setSelector = [setSelector stringByAppendingString:@":"];
    
    [self setMonster:monster];
    [self setSetSelector:NSSelectorFromString(setSelector)];
    [self setGetSelector:NSSelectorFromString(getSelector)];
    [self setProperty:property];
    [self setMin: min];
    [self setMax: max];
    _setInvocation = [self buildInvocation:_setInvocation selector:[self setSelector] andSignature:_setSignature];
    _getInvocation = [self buildInvocation:_getInvocation selector:[self getSelector] andSignature:_getSignature];
    
    [self buildSlider];
    
    return self;
}

- (void) buildSlider
{
    
    float result;
    [_getInvocation invoke];
    [_getInvocation getReturnValue:&result];
    
    // Label
    CGRect labelFrame = CGRectZero;
    labelFrame.origin.x = 10.0f;
    labelFrame.origin.y = 0.0f;
    labelFrame.size.width = [self frame].size.width * 0.3f;
    labelFrame.size.height = 20.0f;
    
    UILabel* label = [[UILabel alloc] init];
    [label setFrame:labelFrame];
    [label setText:[[self property] stringByAppendingString:@":"]];
    [label setAdjustsFontSizeToFitWidth:TRUE];
    [self addSubview:label];
    
    // Slider
    CGRect sliderFrame = CGRectZero;
    sliderFrame.origin.x = CGRectGetMaxX(labelFrame);
    sliderFrame.origin.y = 0.0f;
    sliderFrame.size.width = [self frame].size.width * 0.50f;
    sliderFrame.size.height = 20.0f;
    
    UISlider* slider = [[UISlider alloc] init];
    [slider setMinimumValue:[self min]];
    [slider setMaximumValue:[self max]];
    [slider setFrame:sliderFrame];
    [slider setValue:result];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
    
    // Value Label
    CGRect valueLabelFrame = CGRectZero;
    valueLabelFrame.origin.x = CGRectGetMaxX(sliderFrame);
    valueLabelFrame.origin.y = 0.0f;
    valueLabelFrame.size.width = [self frame].size.width * 0.10f;
    valueLabelFrame.size.height = 20.0f;
    
    _valueLabel = [[UILabel alloc] init];
    [_valueLabel setFrame:valueLabelFrame];
    [_valueLabel setText:[NSString stringWithFormat:@"%0.0f", result]];
    [_valueLabel setAdjustsFontSizeToFitWidth:TRUE];
    [self addSubview:_valueLabel];
}

- (NSInvocation*) buildInvocation:(NSInvocation*)invocation selector:(SEL)selector andSignature:(NSMethodSignature*)signature
{
    signature = [MSTMonster instanceMethodSignatureForSelector:selector];
    invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    
    [invocation setTarget:[self monster]];
    
    return invocation;
}

- (void) valueChanged:(UISlider*)slider
{
    float value = [slider value];
    [_valueLabel setText:[NSString stringWithFormat:@"%0.0f", value]];
    [_setInvocation setArgument:&value atIndex:2];
    [_setInvocation invoke];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
