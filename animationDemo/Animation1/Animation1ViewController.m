//
//  Animation1ViewController.m
//  animationDemo
//
//  Created by duxinxiao on 16/4/21.
//  Copyright © 2016年 duxinxiao. All rights reserved.
//

#import "Animation1ViewController.h"
#import <Masonry.h>
#import "Animation1View.h"

@interface Animation1ViewController ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIView *sideHelperView;
@property (nonatomic, strong) UIView *centerHelperView;
@property (nonatomic, strong) Animation1View *animationView;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) MASConstraint *topConstraint;
@property (nonatomic, assign) NSUInteger *animationCount;
@end

@implementation Animation1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.resetButton];
    [self.view addSubview:self.sideHelperView];
    [self.view addSubview:self.centerHelperView];
    [self.view addSubview:self.animationView];
    [self layoutConstrains];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - events response
- (void)tapHandler:(UIButton *)sender {
    NSLog(@"tap");
    [self.sideHelperView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [self animationBegin];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.9 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self animationEnd];
    }];
    
    
    [self.centerHelperView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    [self animationBegin];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:2.0 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self animationEnd];
    }];
}

- (void)displayHandler:(CADisplayLink *)displayLink {
    CALayer *sideLayer = (CALayer *)[self.sideHelperView.layer presentationLayer];
    CALayer *centerLayer = (CALayer *)[self.centerHelperView.layer presentationLayer];
    [self.topConstraint setOffset:centerLayer.frame.origin.y];
    
    self.animationView.controlOffset = centerLayer.frame.origin.y - sideLayer.frame.origin.y;
    [self.animationView setNeedsDisplay];
}

- (void)resetHandler:(UIButton *)sender {
    NSLog(@"reset");
    [self.sideHelperView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    [self.centerHelperView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    [self.animationView mas_remakeConstraints:^(MASConstraintMaker *make) {
        self.topConstraint = make.top.equalTo(self.view).offset(CGRectGetHeight(self.view.frame));
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.view updateConstraintsIfNeeded];
}

#pragma mark - private method
- (void)layoutConstrains {
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-100.f);
        make.centerX.equalTo(self.view).offset(-100.f);
    }];
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-100.f);
        make.centerX.equalTo(self.view).offset(100.f);
    }];
    [self.sideHelperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    [self.centerHelperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.topConstraint = make.top.equalTo(self.view).offset(CGRectGetHeight(self.view.frame));
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)animationBegin {
    self.animationCount++;
    if (!self.displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayHandler:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)animationEnd {
    self.animationCount--;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}


#pragma makr - accessor
- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"tap!!" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        _button = button;
    }
    return _button;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"reset!!" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(resetHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        _resetButton = button;
    }
    return _resetButton;

}

- (UIView *)sideHelperView {
    if (!_sideHelperView) {
        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor blueColor];
        
        _sideHelperView = view;
    }
    return _sideHelperView;
}

- (UIView *)centerHelperView {
    if (!_centerHelperView) {
        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor yellowColor];
        
        _centerHelperView = view;
    }
    return _centerHelperView;
}

- (Animation1View *)animationView {
    if (!_animationView) {
        Animation1View *view = [[Animation1View alloc] init];
        
        _animationView = view;
    }
    return _animationView;
}

@end
