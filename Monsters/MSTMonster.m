//
//  MSTMonster.m
//  Monsters
//
//  Created by travis elnicky on 1/20/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import "MSTMonster.h"

@implementation MSTMonster
- (id) initWithDefaults
{
    self = [self init];
    if(self == nil)
        return nil;
    
    [self setHeight:MST_MIN_HEIGHT];
    [self setStrength:MST_MIN_STRENGTH];
    [self setArmor:MST_MIN_ARMOR];
    [self setAppendages:MST_MIN_APPENDAGES];
    [self setTeeth:MST_MIN_TEETH];
    [self setClaws:MST_MIN_CLAWS];
    
    return self;
}

- (float) effectiveness
{
    float _effectiveness = 2 * (4 * sinf([self strength] * 0.003) + cos([self height] * 0.23) + 2 * sinf([self armor] * 0.057) - 0.7 * fabs(                                                                                   [self appendages] - 5 ) + 5 * cosf(([self teeth] - 34) * 0.024) + 3 * sinf(([self claws] - [self appendages] * 0.7) * 0.038)) *  0.709;

    return _effectiveness;
}
@end
