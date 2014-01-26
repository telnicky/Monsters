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
    float _toohHeight;
    float _toothWidth;
    CGPoint _mouthStart;
    float _mouthLength;
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
        [self animateMonsterTeeth];

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
    
    // mouth
    UIBezierPath* mouth = [UIBezierPath bezierPath];
    [[UIColor blackColor] setFill];
    [[UIColor blackColor] setStroke];
    float teeth = truncf([[self monster] teeth]);
    float mouthX = CGRectGetMidX(_body) - _mouthLength * 0.5f;
    float mouthY = CGRectGetMidY(_body) + _body.size.height * 0.1f;
    _mouthStart = CGPointMake(mouthX, mouthY);
    [mouth moveToPoint:_mouthStart];

    // teeth
    if (teeth == 0) {
        [mouth addLineToPoint:CGPointMake(mouthX + _mouthLength, _mouthStart.y)];
    }
    else {
        float toothX = _mouthStart.x + _toothWidth * 0.5f;
        float toothY = _toohHeight;
        for (int i = 0; i < teeth; i++) {
            [mouth addLineToPoint:CGPointMake(toothX, toothY)];

            toothX = toothX + (_toothWidth * 0.5f);
            toothY = _mouthStart.y;
            
            [mouth addLineToPoint:CGPointMake(toothX, toothY)];
            
            toothX += (_toothWidth * 0.5f);
            toothY = _toohHeight;
        }
    }
    
    
    
    [mouth addQuadCurveToPoint:_mouthStart controlPoint:CGPointMake(CGRectGetMidX(_body), CGRectGetMaxY(_body))];
    [mouth fill];
    [mouth stroke];
    [mouth closePath];
    
}

- (void)animateMonsterHeight
{

    float heightFactor = ([[self monster] height] / MST_MAX_HEIGHT);
    _body.size.height = MAX([self bounds].size.height * heightFactor, 30.0f);
    _body.origin.y = CGRectGetMaxY([self bounds]) - _body.size.height;
    [self animateMonsterTeeth];
    [self setNeedsDisplay];
}

- (void)animateMonsterStrength
{

    float strengthFactor = ([[self monster] strength] / MST_MAX_STRENGTH);
    _body.size.width = MAX([self bounds].size.width * strengthFactor, 50.0f);
    _body.origin.x = CGRectGetMidX([self bounds]) - _body.size.width * 0.5f;
    [self animateMonsterTeeth];
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

- (void)animateMonsterTeeth
{
    [self setMouthStart];
    [self setMouthLength];
    [self setToothHeight];
    [self setToothWidth];
    [self setNeedsDisplay];
}

- (void) setMouthLength
{
    float teeth = truncf([[self monster] teeth]);
    _mouthLength = _body.size.width * 0.4f + (1.0f * teeth);
    if (_mouthLength > _body.size.width) {
        _mouthLength = _body.size.width;
    }
}

- (void) setMouthStart
{
    float mouthX = CGRectGetMidX(_body) - _mouthLength * 0.5f;
    float mouthY = CGRectGetMidY(_body) + _body.size.height * 0.1f;
    _mouthStart = CGPointMake(mouthX, mouthY);
}

- (void) setToothHeight
{
    float teeth = truncf([[self monster] teeth]);
    _toohHeight = _mouthStart.y + 50.0f / (1.0f + teeth);
}

- (void) setToothWidth
{
    float teeth = truncf([[self monster] teeth]);
    _toothWidth = (teeth == 0) ? 0 : _mouthLength / teeth;
}

@end
