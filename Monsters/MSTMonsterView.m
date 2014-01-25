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
    CGRect _body;
}

- (id)initWithMonster:(MSTMonster*)monster andWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMonster:monster];
        _body = [self bounds];
        [self animateMonsterHeight];
        [self animateMonsterStrength];
        [self animateMonsterArmor];
    }

    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // background
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, [self bounds]);
    CGContextFillPath(context);
    
    // body
    CGContextAddEllipseInRect(context, _body);
    CGContextSetFillColorWithColor(context, [[self armorColor] CGColor]);
    CGContextFillPath(context);
    
    // eyes
    CGRect eyeLeftRect = _body;
    eyeLeftRect = CGRectInset(eyeLeftRect, eyeLeftRect.size.width * 0.4f, eyeLeftRect.size.height * 0.4f);
    eyeLeftRect = CGRectOffset(eyeLeftRect, -eyeLeftRect.size.width * 0.5f, -eyeLeftRect.size.height * 0.5f);
    CGContextAddEllipseInRect(context, eyeLeftRect);
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    CGContextFillPath(context);
    
    CGRect eyeRightRect = eyeLeftRect;
    eyeRightRect = CGRectOffset(eyeRightRect, eyeRightRect.size.width, 0);
    CGContextAddEllipseInRect(context, eyeRightRect);
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    CGContextFillPath(context);
}

- (void)animateMonsterHeight
{

    float heightFactor = ([[self monster] height] / MST_MAX_HEIGHT);
    _body.size.height = [self bounds].size.height * heightFactor;
    _body.origin.y = CGRectGetMaxY([self bounds]) - _body.size.height;

    
    [self setNeedsDisplay];
}

- (void)animateMonsterStrength
{

    float strengthFactor = ([[self monster] strength] / MST_MAX_STRENGTH);
    _body.size.width = [self bounds].size.width * strengthFactor;
    _body.origin.x = CGRectGetMidX([self bounds]) - _body.size.width * 0.5f;
    
    [self setNeedsDisplay];
}

- (void)animateMonsterArmor
{
    float red = [[self monster] armor] * 0.3f / 255.0f;
    float blue = [[self monster] armor] * 1.3f / 255.0f;
    float green = [[self monster] armor] / 255.0f;
    float alpha = [[self monster] armor] * 2.55f / 255.0f + 0.15f;
    [self setArmorColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
    [self setNeedsDisplay];
}


@end
