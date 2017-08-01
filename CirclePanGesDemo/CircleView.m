
//
//  CircleView.m
//  CirclePanGesDemo
//
//  Created by Start on 2017/8/1.
//  Copyright © 2017年 het. All rights reserved.
//

#import "CircleView.h"
#define centerX self.frame.size.width  *0.5
#define centerY self.frame.size.height *0.5
#define Radians_To_Degress(radius) ((radius)*(180.0/M_PI))
#define Radius (centerX - 10)
#define LineWidth 12
@interface CircleView()
//UIBeriziPath + CAShplayer
/**灰色圆弧*/
@property(nonatomic,strong)CAShapeLayer *bgShaperLayer;
/**红色进度条*/
@property(nonatomic,strong)CAShapeLayer *redShaperLayer;
/**添加小圆点*/
@property(nonatomic,strong)UILabel *moveLabel;
/**移动手势*/
@property(nonatomic,strong)UIPanGestureRecognizer *panGes;
@end
@implementation CircleView
/*
 * 1. 背景圆 
   2. 进度条
   3. 添加小圆点
       3.0 计算小圆点的坐标值。通过角度进行换算成 x,y
       3.1 滑动手势 pan
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        
    }
    return self;
}

-(void)setupSubViews
{
    //绘制灰色原型背景
    [self drawBgCircle];
    //绘制红色进度条
    [self drawRedCircle];
    //绘制小方块
    [self addSubview:self.moveLabel];
}

//设置frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.moveLabel.bounds = CGRectMake(0, 0, LineWidth, LineWidth);
    self.moveLabel.layer.cornerRadius = (LineWidth)*0.5;
    
}


//绘制灰色原型背景
-(void)drawBgCircle
{
    UIBezierPath *bgCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:Radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    self.bgShaperLayer = [CAShapeLayer layer];
    self.bgShaperLayer.lineWidth = LineWidth;
    self.bgShaperLayer.fillColor = [UIColor clearColor].CGColor;
    self.bgShaperLayer.strokeColor = [UIColor grayColor].CGColor;
    self.bgShaperLayer.path = bgCircle.CGPath;
    [self.layer addSublayer:self.bgShaperLayer];
}

//绘制红色进度条
-(void)drawRedCircle
{
    UIBezierPath *redCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:Radius startAngle:-M_PI/2 endAngle:M_PI*2 -M_PI/2 clockwise:YES];
    self.redShaperLayer = [CAShapeLayer layer];
    self.redShaperLayer.lineWidth = 10;
    self.redShaperLayer.fillColor = [UIColor clearColor].CGColor;
    self.redShaperLayer.path = redCircle.CGPath;
    [self.layer addSublayer:self.redShaperLayer];
    //先设定movelLabel的坐标
    CGPoint movelPoint = [self pointWithAngle:0];
    self.moveLabel.center = movelPoint;
    
}

//角度转坐标轴
-(CGPoint)pointWithAngle:(double)angle
{
    float x = sin(angle)*Radius;
    float y = cos(angle) *Radius;
    return CGPointMake(x + centerX, centerY - y);
}

//位置转变成角度
-(double)angleWithPoint:(CGPoint)point
{
    float offsetX = point.x - centerX;
    float offsetY = centerY - point.y;
    float touchLength = sqrtf(powf(offsetX, 2)+powf(offsetY, 2));
    double angle = acos(offsetY / touchLength);
    if (offsetX < 0) {
        angle = 2*M_PI -angle;
    }
    return angle;
}


//拖动Label
-(void)movelLabelAction:(UIPanGestureRecognizer *)panGes
{
    //1.根据拖动的位置计算出角度 2.计算StorkEnd的比例 3.同时设置圆点的坐标
    CGPoint touchPoint = [panGes locationInView:self];
    NSLog(@"touchPoint: %@",NSStringFromCGPoint(touchPoint));
    double angleValue =  [self angleWithPoint:touchPoint];
    NSLog(@"角度：%f",angleValue*180/M_PI);
    //设置label的坐标
    self.moveLabel.center = [self pointWithAngle:angleValue];
    //根据角度算出point
    NSLog(@"[self pointWithAngle:angleValue]: %@",NSStringFromCGPoint([self pointWithAngle:angleValue]));
    NSLog(@"angleValue / M_PI*2: %f",angleValue / (M_PI*2));
    self.redShaperLayer.strokeColor = [UIColor redColor].CGColor;
    self.redShaperLayer.strokeEnd = (angleValue) / (M_PI*2);
    
}

//小圆点
-(UILabel *)moveLabel
{
    if (!_moveLabel) {
        _moveLabel = [[UILabel alloc]init];
        _moveLabel.layer.masksToBounds = YES;
        _moveLabel.userInteractionEnabled = YES;
        _moveLabel.backgroundColor = [UIColor orangeColor];
        self.panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(movelLabelAction:)];
        [_moveLabel addGestureRecognizer:self.panGes];
    }
    return _moveLabel;
}

@end
