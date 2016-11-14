//
//  BaseLoadingView.m
//  EmployeeAssistant
//
//  Created by LiHaomiao on 2016/10/10.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BaseLoadingView.h"
#import "LoadingAnimationView.h"

@interface BaseLoadingView()

@property (nonatomic, readwrite, strong) CADisplayLink *displayLink;
@property (nonatomic, readwrite, strong) CALayer *canvasLayer;
@property (nonatomic, readwrite, strong) CAShapeLayer *waveLayer;
@property (nonatomic, readwrite, assign) CGRect backgroundFrame;
@property (nonatomic, readwrite, assign) CGRect shapeFrame;
@end

@implementation BaseLoadingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ){
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)addLoadingView
{
    
    LoadingAnimationView *ani = [[LoadingAnimationView alloc] initWithFrame:CGRectMake(100, 100, 45, 30)];
    [ani startAnimation];
    [self addSubview:ani];
}


- (void)startLoading
{
    
}

- (void)stopLoading
{
    
}

- (void)networkLoadFailure
{
    
}

- (void)networkLoadFailureWithImage:(UIImage *)image
{
    
}

- (void)noMessageWithMessage:(NSString *)message image:(UIImage *)image
{
    
}

- (void)removeView
{
    
}

- (void)loadingDataSuccess
{
    
}
@end
