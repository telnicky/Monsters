//
//  MSTUISliderView.h
//  Monsters
//
//  Created by travis elnicky on 1/21/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSTMonster.h"

@interface MSTSliderView : UIControl
@property SEL setSelector;
@property SEL getSelector;
@property NSString* property;
@property MSTMonster* monster;
@property float min;
@property float max;

- (id) initWithMonster:(MSTMonster*)monster property:(NSString*)property min:(float)min max:(float)max andFrame:(CGRect)frame;

@end
