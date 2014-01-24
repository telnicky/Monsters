//
//  MSTMonsterView.m
//  Monsters
//
//  Created by travis elnicky on 1/23/14.
//  Copyright (c) 2014 Travis Elnicky. All rights reserved.
//

#import "MSTMonsterView.h"

@implementation MSTMonsterView
{
    
}

- (id)initWithMonster:(MSTMonster*)monster andWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMonster:monster];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // body
    CGRect body = [self bounds];
    float heightFactor = ([[self monster] height] / MST_MAX_HEIGHT);
    body.size.height = body.size.height * heightFactor;
    CGContextAddEllipseInRect(context, body);
    CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextFillPath(context);
}


@end
