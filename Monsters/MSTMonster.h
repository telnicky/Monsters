//
//  MSTMonster.h
//  Monsters
//
//  Created by travis elnicky on 1/20/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MST_MIN_HEIGHT 1
#define MST_MAX_HEIGHT 50

#define MST_MIN_STRENGTH 1
#define MST_MAX_STRENGTH 1000

#define MST_MIN_ARMOR 1
#define MST_MAX_ARMOR 100

#define MST_MIN_APPENDAGES 1
#define MST_MAX_APPENDAGES 10

#define MST_MIN_TEETH 0
#define MST_MAX_TEETH 100

#define MST_MIN_CLAWS 0
#define MST_MAX_CLAWS 25

@interface MSTMonster : NSObject
@property float height;
@property float strength;
@property float armor;
@property float appendages;
@property float teeth;
@property float claws;
@property NSString* name;

- (id) initWithDefaults;
- (float) effectiveness;

@end
