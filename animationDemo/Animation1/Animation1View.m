//
//  Animation1View.m
//  animationDemo
//
//  Created by duxinxiao on 16/4/21.
//  Copyright © 2016年 duxinxiao. All rights reserved.
//

#import "Animation1View.h"

@implementation Animation1View

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat yOffset = 30.0;
    CGFloat width   = CGRectGetWidth(rect);
    CGFloat height  = CGRectGetHeight(rect);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0, yOffset)]; //去设置初始线段的起点
    CGPoint controlPoint = CGPointMake(width / 2, yOffset + self.controlOffset);
    [path addQuadCurveToPoint:CGPointMake(width, yOffset) controlPoint:controlPoint];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0.0, height)];
    [path closePath];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [[UIColor lightGrayColor] set];
    CGContextFillPath(context);
}

@end
