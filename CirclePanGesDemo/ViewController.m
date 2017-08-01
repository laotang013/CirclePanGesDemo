//
//  ViewController.m
//  CirclePanGesDemo
//
//  Created by Start on 2017/8/1.
//  Copyright © 2017年 het. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
@interface ViewController ()
/**CircleView*/
@property(nonatomic,strong)CircleView *circleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupSubViews];
}

-(void)setupSubViews
{
    [self.view addSubview:self.circleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - **************** 懒加载
-(CircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[CircleView alloc]initWithFrame:CGRectMake(80, 50, 200, 200)];
        //_circleView.backgroundColor = [UIColor orangeColor];
        
    }
    return _circleView;
}
@end
