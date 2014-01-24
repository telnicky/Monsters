//
//  MSTMonsterView.h
//  Monsters
//
//  Created by travis elnicky on 1/20/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSTMonster.h"
#import "MSTSliderView.h"
#import "MSTMonsterView.h"

@interface MSTMonstersView : UIView <UITextFieldDelegate>
@property MSTMonster* monster;

- (id) initWithMonster:(MSTMonster*) monster andWithFrame:(CGRect) frame;
@end
