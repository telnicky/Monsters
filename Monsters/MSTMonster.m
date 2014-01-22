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
    [self setStrength:MST_MAX_STRENGTH];
    [self setArmor:MST_MIN_ARMOR];
    [self setAppendages:MST_MIN_APPENDAGES];
    [self setTeeth:MST_MIN_TEETH];
    [self setClaws:MST_MIN_CLAWS];
    
    return self;
}
@end
