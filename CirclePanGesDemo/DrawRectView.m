

//
//  DrawRectView.m
//  CirclePanGesDemo
//
//  Created by Start on 2017/8/2.
//  Copyright © 2017年 het. All rights reserved.
//

#import "DrawRectView.h"
@interface DrawRectView()

@end
@implementation DrawRectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    
    //UIBezierPath包装了Quartz的相关的API,自己存在于UIKit中,因此不是基于C的API,而是
    //基于Object-c对象的。clockwise参数是和现实一样的，如果需要顺时针就传YES
    
    /*
     * iOS 绘图 http://www.jianshu.com/p/8e6e960eea7d
          iOS系统本身提供了两套绘图的框架，即UIBezierPath 和 Core Graphics。而前者所属UIKit，其实是对Core Graphics框架关于path的进一步封装，所以使用起来比较简单。但是毕竟Core Graphics更接近底层，所以它更加强大。
      1.1 UIBezierPath 
         1.1.1 可以创建基于矢量的路径,使用UIBezierPath,你只能在当前的上下文中绘图。
         1.1.2 一般使用UIBezierPath都是在重写的drawRect方法中绘制步骤如下:
             1.1.2.1 重写drawRect方法,但不需要自己获取当前上下文context。
             1.1.2.2 创建相应的UIBezierPath对象并设置一些修饰属性
             1.1.2.3 渲染,完成绘制。
         
         1.1.3
             多边形是一些简单的形状,这些形状是由一些直线线条组成，我们可以用moveToPoint: 和 addLineToPoint:方法去构建。moveToPoint:设置我们想要创建形状的起点。从这点开始，我们可以用方法addLineToPoint:去创建一个形状的线段。
             我们可以连续的创建line，每一个line的起点都是先前的终点，终点就是指定的点。
             closePath可以在最后一个点和第一个点之间画一条线段。
 
     2.1 Core Graphics
         2.1.1 这是一个绘图的API族,它经常称为QuartZ或QuartZ 2D。Core Graphics是iOS所有绘图功能的的基石。包括UIKit。
         2.1.2 
               1.绘图需要CGContextRef
                     CGContextRef即图形上下文理解为我们绘图需要一个载体或者说输出目标，用它来显示绘图信息,并且决定绘制的东西输出到哪个地方。可以形象的比喻context就像一个“画板”，我们得把图形绘制到这个画板上。所以，绘图必须要先有context。
     2.2.怎么拿到context？第一种方法是利用cocoa为你生成的图形上下文。当你子类化了一个UIView并实现了自己的drawRect：方法后，一旦drawRect：方法被调用，Cocoa就会为你创建一个图形上下文，此时你对图形上下文的所有绘图操作都会显示在UIView上。
     
         第二种方法就是创建一个图片类型的上下文。调用UIGraphicsBeginImageContextWithOptions函数就可获得用来处理图片的图形上下文。利用该上下文，你就可以在其上进行绘图，并生成图片。调用UIGraphicsGetImageFromCurrentImageContext函数可从当前上下文中获取一个UIImage对象。记住在你所有的绘图操作后别忘了调用UIGraphicsEndImageContext函数关闭图形上下文。
             简言之：
             重写UIView的drawRect方法，在该方法里便可得到context；
             调用UIGraphicsBeginImageContextWithOptions方法得到context；
        2.2.2.drawRect方法什么时候触发
             
             1.当view第一次显示到屏幕上时；
             2.当调用view的setNeedsDisplay或者setNeedsDisplayInRect:方法时。
       2.2.3 步骤:
             1.先在drawRect方法中获得上下文context；
             2.绘制图形（线，图形，图片等）；
             3.设置一些修饰属性；
             4.渲染到上下文，完成绘图。
     */
    
    
    
    NSLog(@"drawRect");
    
    [self test2];

}

-(void)test0
{
    //创建UIBezierPth对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path  addLineToPoint:CGPointMake(10, 50)];
    //设置一些路径
    path.lineWidth = 2;
    path.lineCapStyle = kCGLineCapRound;//线条拐角
    path.lineJoinStyle = kCGLineCapRound;//线条终点
    [[UIColor whiteColor]setStroke];
    //渲染
    [path stroke];

}

-(void)test
{
    //开始图像绘图
    UIGraphicsBeginImageContext(self.bounds.size);
    //获取当前CGContextRef
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    //左眼
    CGPathAddEllipseInRect(path, &transform, CGRectMake(0, 0, 20, 20));
    //右眼
    CGPathAddEllipseInRect(path, &transform, CGRectMake(80, 0, 20, 20));
    //笑
    CGPathMoveToPoint(path, &transform, 100, 50);
    CGPathAddArc(path, &transform, 50, 50, 50, 0, M_PI, NO);
    //将CGMutablePathRef添加到当前Context内
    CGContextAddPath(gc, path);
    //设置绘图属性
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(gc, 2);
    //执行绘画
    CGContextStrokePath(gc);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imgView];
}

//裁剪View形成自定义View
-(void)test2
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(100, 100) radius:90 startAngle:-M_PI endAngle:0 clockwise:YES];
    [[UIColor blueColor] set];
    
    
    [path fill];
}
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
    //定义一个UIButton
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(170, 20, 30, 20)];
//    [button setBackgroundColor:[UIColor purpleColor]];
//    [button setTitle:@"点击" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
//    [self addSubview:button];
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];

    //判断调用顺序
    NSLog(@"frame");

}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint yellowPoint = [self convertPoint:point toView:self];
    if ([self pointInside:yellowPoint withEvent:event]) {
        return self;
    }
    
    return [super hitTest:point withEvent:event];
}


-(void)buttonClick
{
    NSLog(@"按钮点击了");
}
@end
