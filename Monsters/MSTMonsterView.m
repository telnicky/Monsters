//
//  MSTMonsterView.m
//  Monsters
//
//  Created by travis elnicky on 1/20/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import "MSTMonsterView.h"

@implementation MSTMonsterView
{
    UILabel* _effectivenessLabel;
}

- (id) initWithMonster:(MSTMonster*)monster andWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if(self == nil)
        return nil;
    
    [self setMonster:monster];
    [self buildView];
    
    return self;
}

- (void) buildView
{
    // Image
    CGRect imageFrame = CGRectZero;
    imageFrame.origin.x = self.frame.origin.x;
    imageFrame.origin.y = self.frame.origin.y + 20.0f;
    imageFrame.size.width = [self frame].size.width;
    imageFrame.size.height = [self frame].size.height * 0.40f;
    
    UIImage* image = [UIImage imageNamed:@"monster"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:imageFrame];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:imageView];
    
    // Height Slider
    CGRect heightSliderFrame = CGRectZero;
    heightSliderFrame.origin.x = 10.0f;
    heightSliderFrame.origin.y = CGRectGetMaxY(imageFrame) + 10.0f;
    heightSliderFrame.size.width = [self frame].size.width;
    heightSliderFrame.size.height = 30.0f;
    
    MSTUISliderView* heightSlider = [MSTUISliderView alloc];
    heightSlider = [heightSlider initWithMonster:[self monster]
                                        property:@"Height"
                                             min:MST_MIN_HEIGHT
                                             max:MST_MAX_HEIGHT
                                        andFrame:heightSliderFrame];
    [heightSlider addTarget:self action:@selector(updateEffectiveness) forControlEvents:UIControlEventValueChanged];
    [self addSubview:heightSlider];
    
    // Strength Slider
    CGRect strengthSliderFrame = CGRectZero;
    strengthSliderFrame.origin.x = 10.0f;
    strengthSliderFrame.origin.y = CGRectGetMaxY(heightSliderFrame) + 10.0f;
    strengthSliderFrame.size.width = [self frame].size.width;
    strengthSliderFrame.size.height = 30.0f;
    
    MSTUISliderView* strengthSlider = [MSTUISliderView alloc];
    strengthSlider = [strengthSlider initWithMonster:[self monster]
                                            property:@"Strength"
                                                 min:MST_MIN_STRENGTH
                                                 max:MST_MAX_STRENGTH
                                            andFrame:strengthSliderFrame];
    [strengthSlider addTarget:self action:@selector(updateEffectiveness) forControlEvents:UIControlEventValueChanged];
    [self addSubview:strengthSlider];
    
    // Armor Slider
    CGRect armorSliderFrame = CGRectZero;
    armorSliderFrame.origin.x = 10.0f;
    armorSliderFrame.origin.y = CGRectGetMaxY(strengthSliderFrame) + 10.0f;
    armorSliderFrame.size.width = [self frame].size.width;
    armorSliderFrame.size.height = 30.0f;
    
    MSTUISliderView* armorSlider = [MSTUISliderView alloc];
    armorSlider = [armorSlider initWithMonster:[self monster]
                                      property:@"Armor"
                                           min:MST_MIN_ARMOR
                                           max:MST_MAX_ARMOR
                                      andFrame:armorSliderFrame];
    [armorSlider addTarget:self action:@selector(updateEffectiveness) forControlEvents:UIControlEventValueChanged];
    [self addSubview:armorSlider];
    
    // Appendages Slider
    CGRect appendagesSliderFrame = CGRectZero;
    appendagesSliderFrame.origin.x = 10.0f;
    appendagesSliderFrame.origin.y = CGRectGetMaxY(armorSliderFrame) + 10.0f;
    appendagesSliderFrame.size.width = [self frame].size.width;
    appendagesSliderFrame.size.height = 30.0f;
    
    MSTUISliderView* appendagesSlider = [MSTUISliderView alloc];
    appendagesSlider = [appendagesSlider initWithMonster:[self monster]
                                      property:@"Appendages"
                                           min:MST_MIN_APPENDAGES
                                           max:MST_MAX_APPENDAGES
                                      andFrame:appendagesSliderFrame];
    [appendagesSlider addTarget:self action:@selector(updateEffectiveness) forControlEvents:UIControlEventValueChanged];
    [self addSubview:appendagesSlider];
    
    
    // Teeth Slider
    CGRect teethSliderFrame = CGRectZero;
    teethSliderFrame.origin.x = 10.0f;
    teethSliderFrame.origin.y = CGRectGetMaxY(appendagesSliderFrame) + 10.0f;
    teethSliderFrame.size.width = [self frame].size.width;
    teethSliderFrame.size.height = 30.0f;
    
    MSTUISliderView* teethSlider = [MSTUISliderView alloc];
    teethSlider = [teethSlider initWithMonster:[self monster]
                                      property:@"Teeth"
                                           min:MST_MIN_TEETH
                                           max:MST_MAX_TEETH
                                      andFrame:teethSliderFrame];
    [teethSlider addTarget:self action:@selector(updateEffectiveness) forControlEvents:UIControlEventValueChanged];
    [self addSubview:teethSlider];
    
    
    // Claws Slider
    CGRect clawsSliderFrame = CGRectZero;
    clawsSliderFrame.origin.x = 10.0f;
    clawsSliderFrame.origin.y = CGRectGetMaxY(teethSliderFrame) + 10.0f;
    clawsSliderFrame.size.width = [self frame].size.width;
    clawsSliderFrame.size.height = 30.0f;
    
    MSTUISliderView* clawsSlider = [MSTUISliderView alloc];
    clawsSlider = [clawsSlider initWithMonster:[self monster]
                                      property:@"Claws"
                                           min:MST_MIN_CLAWS
                                           max:MST_MAX_CLAWS
                                      andFrame:clawsSliderFrame];
    [clawsSlider addTarget:self action:@selector(updateEffectiveness) forControlEvents:UIControlEventValueChanged];
    [self addSubview:clawsSlider];
    
    
    // Effectiveness Label
    CGRect effectivenessLabelFrame = CGRectZero;
    effectivenessLabelFrame.size.width = 60.0f;
    effectivenessLabelFrame.size.height = 25.0f;
    effectivenessLabelFrame.origin.x = CGRectGetMidX([self frame]) - effectivenessLabelFrame.size.width * 0.5f;
    effectivenessLabelFrame.origin.y = CGRectGetMaxY(clawsSliderFrame);
    
    
    _effectivenessLabel = [[UILabel alloc] init];
    [self updateEffectiveness];
    [_effectivenessLabel setTextColor:[UIColor redColor]];
    [_effectivenessLabel setFrame:effectivenessLabelFrame];
    [_effectivenessLabel setAdjustsFontSizeToFitWidth:TRUE];
    [_effectivenessLabel setFont:[UIFont boldSystemFontOfSize:32]];
    [self addSubview:_effectivenessLabel];
    
}

- (void) updateEffectiveness
{
    [_effectivenessLabel setText:[NSString stringWithFormat:@"%0.1f", [[self monster] effectiveness]]];
}

@end
