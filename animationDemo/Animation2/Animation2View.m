//
//  Animation2View.m
//  animationDemo
//
//  Created by duxinxiao on 16/4/22.
//  Copyright © 2016年 duxinxiao. All rights reserved.
//

#import "Animation2View.h"

@interface Animation2View ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation Animation2View

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.backgroundColor = [UIColor colorWithRed:102/255.f green:204/255.f blue:255/255.f alpha:1];
        UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        [self addGestureRecognizer:gr];
    }
    return self;
}

- (void)panGestureHandler:(UIPanGestureRecognizer *)gr {
    CGFloat xOffset = [gr translationInView:self].x;
    if (gr.state == UIGestureRecognizerStateChanged) {
        if (xOffset > 0) {
            self.shapeLayer.path = [self getLeftPath:xOffset];
        }
        else if (xOffset < 0) {
            self.shapeLayer.path = [self getRightPath:fabs(xOffset)];
        }
    }
    
    if (gr.state == UIGestureRecognizerStateEnded || gr.state == UIGestureRecognizerStateFailed || gr.state == UIGestureRecognizerStateCancelled) {
        if (xOffset > 0) {
//            [self removeGestureRecognizer:gr];
            //TODO: 增加回复动画
        }
        else {
//            [self removeGestureRecognizer:gr];
            //TODO: 增加回复动画
        }
    }
}

#pragma mark - private methods
- (void)setup {
    if (!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1.0;
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        
        [self.layer addSublayer:shapeLayer];
        _shapeLayer = shapeLayer;
    }
}

- (CGPathRef)getLeftPath:(CGFloat)xOffset { //return 为CGPathRef或CGPath *
    UIBezierPath *berzierPath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint midControlPoint = CGPointMake(xOffset, CGRectGetHeight(self.frame) / 2);
    CGPoint endPoint = CGPointMake(0, CGRectGetHeight(self.frame));
    
    [berzierPath moveToPoint:startPoint];
    [berzierPath addQuadCurveToPoint:endPoint controlPoint:midControlPoint];
    [berzierPath closePath];
    
    return [berzierPath CGPath];
}

- (CGPathRef)getRightPath:(CGFloat)xOffset {
    UIBezierPath *berzierPath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(CGRectGetWidth(self.frame), 0);
    CGPoint midControlPoint = CGPointMake(CGRectGetWidth(self.frame) - xOffset, CGRectGetHeight(self.frame) / 2);
    CGPoint endPoint = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    [berzierPath moveToPoint:startPoint];
    [berzierPath addQuadCurveToPoint:endPoint controlPoint:midControlPoint];
    [berzierPath closePath];
    
    return [berzierPath CGPath];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
