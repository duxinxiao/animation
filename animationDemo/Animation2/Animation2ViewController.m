//
//  Animation2ViewController.m
//  animationDemo
//
//  Created by duxinxiao on 16/4/22.
//  Copyright © 2016年 duxinxiao. All rights reserved.
//

#import "Animation2ViewController.h"
#import "Animation2View.h"
#import <Masonry.h>

@interface Animation2ViewController ()
@property (nonatomic, strong) Animation2View *animationView;
@end

@implementation Animation2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.animationView];
    [self layoutConstrains];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)layoutConstrains {
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark - accessor
- (Animation2View *)animationView {
    if (!_animationView) {
        _animationView = [[Animation2View alloc] init];
    }
    return _animationView;
}
@end
