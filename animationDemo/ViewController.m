//
//  ViewController.m
//  animationDemo
//
//  Created by duxinxiao on 16/4/21.
//  Copyright © 2016年 duxinxiao. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "Animation1ViewController.h"
#import "Animation2ViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableview];
    [self layouConstrains];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"animationDemoTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *title = _dataSource[indexPath.row];
    if ([title isEqualToString:@"1CADisplayLink+UIBezierPath"]) {
        NSLog(@"1");
        Animation1ViewController *vc = [[Animation1ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"2UIBezierPath"]) {
        NSLog(@"2");
        Animation2ViewController *vc = [[Animation2ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - private methods
- (void)loadData {
    _dataSource = @[@"1CADisplayLink+UIBezierPath", @"2UIBezierPath", @"3CAShapeLayer"];
    [self.tableview reloadData];
}

- (void)layouConstrains {
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64.f);
    }];
}

#pragma mark - accessors
- (UITableView *)tableview {
    if (!_tableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        _tableview = tableView;
    }
    return _tableview;
}
@end
