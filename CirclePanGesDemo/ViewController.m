//
//  ViewController.m
//  CirclePanGesDemo
//
//  Created by Start on 2017/8/1.
//  Copyright © 2017年 het. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "DrawRectView.h"
@interface ViewController ()
/**CircleView*/
@property(nonatomic,strong)CircleView *circleView;
/**DrawRectView*/
@property(nonatomic,strong)DrawRectView *drawRectView;
/**<#name#>*/
@property(nonatomic,strong)UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupSubViews];
}

-(void)setupSubViews
{
    //[self.view addSubview:self.circleView];
    
    //定义一个UIButton
//    self.button = [[UIButton alloc]initWithFrame:CGRectMake(240, 60, 30, 20)];
//    [self.button setBackgroundColor:[UIColor purpleColor]];
//    [self.button setTitle:@"点击" forState:UIControlStateNormal];
//    self.button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
//    [self.view addSubview:self.button];
//    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    self.button.userInteractionEnabled = YES;
    [self.view addSubview:self.drawRectView];
    

}



-(void)buttonClick
{
    NSLog(@"按钮点击了");
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

-(DrawRectView *)drawRectView
{
    if (!_drawRectView) {
        _drawRectView = [[DrawRectView alloc]initWithFrame:CGRectMake(80, 50, 200, 100)];
        _drawRectView.backgroundColor = [UIColor orangeColor];

    }
    return _drawRectView;
}



@end
