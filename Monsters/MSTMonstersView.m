//
//  MSTMonsterView.m
//  Monsters
//
//  Created by travis elnicky on 1/20/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import "MSTMonstersView.h"

@implementation MSTMonstersView
{
    NSMutableArray* _monsters;
    int _currentIndex;
    UILabel* _effectivenessLabel;
    UIButton* _backButton;
    MSTMonsterView* _monsterView;
    UITextField* _nameTextField;
}

- (id) initWithMonster:(MSTMonster*)monster andWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if(self == nil)
        return nil;

    _currentIndex = 0;
    _monsters = [[NSMutableArray alloc] init];
    [self setMonster:monster];
    [_monsters addObject:monster];
    [self buildView];
    
    return self;
}

- (void) buildView
{
    // Image
    CGRect monsterViewFrame = CGRectZero;
    monsterViewFrame.origin.x = self.frame.origin.x;
    monsterViewFrame.origin.y = self.frame.origin.y + 50.0f;
    monsterViewFrame.size.width = [self frame].size.width;
    monsterViewFrame.size.height = [self frame].size.height * 0.35f;
    
    _monsterView = [[MSTMonsterView alloc] initWithMonster:[self monster] andWithFrame:monsterViewFrame];
    [self addSubview:_monsterView];
    
    // Name Textfield
    CGRect nameTextFieldFrame = CGRectZero;
    nameTextFieldFrame.size.width = [self frame].size.width;
    nameTextFieldFrame.size.height = 30.0f;
    nameTextFieldFrame.origin.x = 0;
    nameTextFieldFrame.origin.y = 20.0f;
    
    _nameTextField = [[UITextField alloc] init];
    [_nameTextField setFrame:nameTextFieldFrame];
    [_nameTextField setPlaceholder:@"name..."];
    [_nameTextField setTextAlignment:NSTextAlignmentCenter];
    if ([[self monster] name] != nil) {
        [_nameTextField setText:[[self monster] name]];
    }
    [_nameTextField addTarget:self action:@selector(updateMonsterName:) forControlEvents:UIControlEventEditingChanged];
    [_nameTextField setDelegate:self];
    [self addSubview:_nameTextField];
    
    // Height Slider
    CGRect heightSliderFrame = CGRectZero;
    heightSliderFrame.origin.x = 10.0f;
    heightSliderFrame.origin.y = CGRectGetMaxY(monsterViewFrame) + 10.0f;
    heightSliderFrame.size.width = [self frame].size.width;
    heightSliderFrame.size.height = 30.0f;
    
    MSTSliderView* heightSlider = [MSTSliderView alloc];
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
    
    MSTSliderView* strengthSlider = [MSTSliderView alloc];
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
    
    MSTSliderView* armorSlider = [MSTSliderView alloc];
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
    
    MSTSliderView* appendagesSlider = [MSTSliderView alloc];
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
    
    MSTSliderView* teethSlider = [MSTSliderView alloc];
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
    
    MSTSliderView* clawsSlider = [MSTSliderView alloc];
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
    
    
    // Next button
    CGRect nextButtonFrame = CGRectZero;
    nextButtonFrame.size.width = 34.0f;
    nextButtonFrame.size.height = 34.0f;
    nextButtonFrame.origin.x = CGRectGetMaxX([self frame]) - 40.0f;
    nextButtonFrame.origin.y = effectivenessLabelFrame.origin.y - 10.0f;
    
    UIButton* nextButton = [[UIButton alloc] init];
    [nextButton setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
    [nextButton setFrame:nextButtonFrame];
    [nextButton addTarget:self action:@selector(nextMonster) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextButton];
    
    // Back button
    CGRect backButtonFrame = nextButtonFrame;
    backButtonFrame.origin.x = 40.0f;
    
    _backButton = [[UIButton alloc] init];
    [_backButton setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
    [_backButton setImage:[UIImage imageNamed:@"left-arrow-disabled"] forState:UIControlStateDisabled];
    [_backButton setFrame:backButtonFrame];
    _backButton.enabled = (_currentIndex == 0) ? FALSE : TRUE;
    [_backButton addTarget:self action:@selector(backMonster) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    
}

- (void) updateEffectiveness
{
    [_effectivenessLabel setText:[NSString stringWithFormat:@"%0.1f", [[self monster] effectiveness]]];
    
    [_monsterView setNeedsDisplay];
}

- (void) nextMonster
{
    _currentIndex++;
    if (_currentIndex == [_monsters count]) {
        MSTMonster* newMonster = [[MSTMonster alloc] initWithDefaults];
        [_monsters addObject:newMonster];
    }
    
    [self setMonster:[_monsters objectAtIndex:_currentIndex]];
    [self redrawView];
    
    _backButton.enabled = TRUE;
}

- (void) backMonster
{
    _currentIndex--;
    if (_currentIndex == 0) {
        _backButton.enabled = FALSE;
    }
    
    [self setMonster:[_monsters objectAtIndex:_currentIndex]];
    [self redrawView];
}

- (void) redrawView
{
    NSArray *subViews = [self subviews];
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    [self buildView];
    [_monsterView setNeedsDisplay];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nameTextField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return FALSE;
}

- (void) updateMonsterName:(UITextField*)textField
{
    [[self monster] setName:[textField text]];
}

@end
