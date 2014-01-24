//
//  MSTMonsterView.h
//  Monsters
//
//  Created by travis elnicky on 1/23/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTMonster.h"

@interface MSTMonsterView : UIView
@property MSTMonster* monster;
- (id)initWithMonster:(MSTMonster*)monster andWithFrame:(CGRect)frame;

@end
