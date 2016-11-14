//
//  loadingAnimationView.m
//  EmployeeAssistant
//
//  Created by LiHaomiao on 2016/10/10.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "LoadingAnimationView.h"

static NSString *const XXALoadingAnimationKey = @"loadingAnimation";
static const CGFloat XXAWidthGapcardinal = 25.0f;

@interface LoadingAnimationView()

@property (nonatomic, readwrite, strong) CADisplayLink *displayLink;
@property (nonatomic, readwrite, strong) CALayer *canvasLayer;
@property (nonatomic, readwrite, strong) CAShapeLayer *waveLayer;
@property (nonatomic, readwrite, assign) CGRect backgroundFrame;
@property (nonatomic, readwrite, assign) CGRect shapeFrame;
@property (nonatomic, readwrite, strong) CABasicAnimation *lodingAnimation;

@end

@implementation LoadingAnimationView

static float phase = 0;
static float phaseShift = 0.2;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ){
        [self p_addAnimationLayerWithFrame:frame];
    }
    return self;
}


#pragma mark - action

- (void)startAnimation
{
    [self.displayLink invalidate];
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(p_update)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    self.waveLayer.hidden = NO;
    [self.waveLayer addAnimation:_lodingAnimation forKey:XXALoadingAnimationKey];
    
}

- (void)stopAnimation
{
    [self.waveLayer removeAllAnimations];
    self.waveLayer.hidden = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}


#pragma mark - p_func

- (void)p_addAnimationLayerWithFrame:(CGRect)frame
{
    
    CGFloat shapePointY = frame.size.height;
    
    _backgroundFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _shapeFrame = CGRectMake(0, shapePointY, frame.size.width, frame.size.height);
    
    //创建背景layer，承载动画需要的所有layer
    CALayer *bglayer = [CALayer layer];
    bglayer.frame = _backgroundFrame;
    bglayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:bglayer];
    
    //容器layer,调用图片的外观
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = _backgroundFrame;
    UIImage *maskImage = [UIImage imageNamed:@"logo-gray"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    bglayer.mask = maskLayer;
    
    //动画背景layer，承载动画的layer
    CALayer *canvaLayer = [CALayer layer];
    canvaLayer.frame = _backgroundFrame;
    canvaLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [bglayer addSublayer:canvaLayer];
    _canvasLayer = canvaLayer;
    
    //动画的layer
    _waveLayer = [CAShapeLayer layer];
    _waveLayer.frame = _shapeFrame;
    _canvasLayer.mask = _waveLayer;
    
    [self p_creadAnimation];
    
}

- (void)p_creadAnimation
{
    //获得结束时的position.y值
    CGPoint position = self.waveLayer.position;
    position.y = position.y - self.shapeFrame.size.height;
    _lodingAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    _lodingAnimation.fromValue = [NSValue valueWithCGPoint:self.waveLayer.position];
    _lodingAnimation.toValue = [NSValue valueWithCGPoint:position];
    _lodingAnimation.duration = 5.0;
    _lodingAnimation.repeatCount = HUGE_VALF;
    _lodingAnimation.removedOnCompletion = NO;
}

//波浪滚动 phase相位每桢变化值：phaseShift
- (void)p_update
{
    CGRect frame = self.backgroundFrame;
    phase += phaseShift;
    UIGraphicsBeginImageContext(frame.size);
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    //用UIBezierPath画一个闭合的路径
    CGFloat endX = 0;
    CGFloat cardinal = frame.size.width / XXAWidthGapcardinal;
    
    for(CGFloat x = 0; x <= frame.size.width ; x += 1) {
        endX=x;
        //正弦函数，求y值
        CGFloat y = cardinal * sinf(2 * M_PI *(x / frame.size.width)  + phase) ;
        
        if (x==0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        }else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    CGFloat endY = CGRectGetHeight(frame);
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    //修改每桢的wavelayer.path
    self.waveLayer.path = [wavePath CGPath];
    UIGraphicsEndImageContext();
}

#pragma mark - dealloc

- (void)dealloc
{
    [_displayLink invalidate];
    _displayLink = nil;
}



@end
