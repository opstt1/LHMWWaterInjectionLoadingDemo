//
//  LoadingView.m
//  EmployeeAssistant
//
//  Created by LiHaomiao on 2016/10/10.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "LoadingView.h"
#import "LoadingAnimationView.h"
//#import "Tookit.h"
//#import "constant.h"

static const CGFloat XEALoadingViewWidht = 80.0f;
static const CGFloat XEALoadingAnimationViewWidth = 40.0f;
static const CGFloat XEALoadingAnimationViewHeight = 30.0f;
static const CGFloat XEAMessageImageViewWidth = 100.0f;
static const CGFloat XEARelodButtonWidth = 80.0f;
static const CGFloat XEARelodButtonHeight= 30.0f;

@interface LoadingView()

@property (nonatomic, readwrite, strong) LoadingAnimationView *loadingAnimation;
@property (nonatomic, readwrite, strong) UIView *loadingView;

@property (nonatomic, readwrite, strong) UIImageView *messageImgeView;
@property (nonatomic, readwrite, strong) UILabel *messageLabel;
@property (nonatomic, readwrite, strong) UIButton *reloadButton;

@property (nonatomic, readwrite, assign) CGFloat selfWidth;
@property (nonatomic, readwrite, assign) CGFloat selfHeight;

@end

@implementation LoadingView

+ (LoadingView *)addToSuperView:(UIView *)superView Frame:(CGRect)frame
{
    LoadingView *view = [[self alloc] initWithFrame:frame];
    [superView addSubview:view];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ){
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self p_initView];
        NSLog(@"initWithFrame");
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if ( self ){
        NSLog(@"super  %@",[self.superview description]);
    }
    return self;
}

- (void)p_initView
{
    _selfWidth = self.frame.size.width;
    _selfHeight = self.frame.size.height;
    
    [self p_creatLoadingView];
    [self p_creatMessageImageView];
    [self p_creatMessageLabel];
    [self p_creatReloadButton];
}

- (void)p_creatLoadingView
{
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-XEALoadingViewWidht/2, SCREEN_HEIGHT/2-XEALoadingViewWidht/2, XEALoadingViewWidht, XEALoadingViewWidht)];
    _loadingView.backgroundColor = [UIColor whiteColor];
    _loadingView.layer.cornerRadius = 8.0f;
    
    _loadingAnimation = [[LoadingAnimationView alloc] initWithFrame:CGRectMake(XEALoadingViewWidht/2-XEALoadingAnimationViewWidth/2, XEALoadingViewWidht/2-XEALoadingAnimationViewHeight/2, XEALoadingAnimationViewWidth, XEALoadingAnimationViewHeight)];
    [_loadingView addSubview:_loadingAnimation];
    
    _loadingView.hidden = YES;
    [self addSubview:_loadingView];
}

- (void)p_creatMessageImageView
{
    _messageImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-XEAMessageImageViewWidth/2, SCREEN_HEIGHT/2-150, XEAMessageImageViewWidth, XEAMessageImageViewWidth)];
    _messageImgeView.hidden = YES;
    [self addSubview:_messageImgeView];
}

- (void)p_creatMessageLabel
{
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-40, SCREEN_WIDTH, 40)];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.font = [UIFont systemFontOfSize:16.0f];
    _messageLabel.numberOfLines = 2;
//    _messageLabel.textColor = COLOR_999999;
    _messageLabel.minimumScaleFactor = 0.5f;
    _messageLabel.hidden = YES;
    [self addSubview:_messageLabel];
    
}

- (void)p_creatReloadButton
{
    _reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-XEARelodButtonWidth/2, SCREEN_HEIGHT/2+XEARelodButtonHeight/2, XEARelodButtonWidth, XEARelodButtonHeight)];
    [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
//    [_reloadButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    [_reloadButton setBackgroundColor:[UIColor clearColor]];
    [_reloadButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    _reloadButton.hidden = YES;
    [_reloadButton addTarget:self action:@selector(p_didTapReloadButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reloadButton];
}

- (void)p_allHidden
{
    self.loadingAnimation.hidden = YES;
    self.loadingView.hidden = YES;
    self.messageLabel.hidden = YES;
    self.messageImgeView.hidden = YES;
    self.reloadButton.hidden = YES;
}

- (void)p_setMessage:(NSString *)message icon:(UIImage *)icon
{
    [self stopLoading];
    self.hidden = NO;
    
    [_messageImgeView setImage:icon];
    _messageImgeView.hidden = NO;
    [_messageLabel setText:message];
    _messageLabel.hidden = NO;

}

#pragma mark -

- (void)startLoading
{
    [self p_allHidden];
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    self.loadingView.hidden = NO;
    self.loadingAnimation.hidden = NO;
    [self.loadingAnimation startAnimation];
    self.hidden = NO;
}


- (void)stopLoading
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.loadingAnimation stopAnimation];
    self.loadingAnimation.hidden = YES;
    self.loadingView.hidden = YES;
    self.hidden = YES;
}

- (void)removeView
{
    [self stopLoading];
    [self removeFromSuperview];
}

- (void)loadingDataSuccess
{
    [self removeView];
}

- (void)networkLoadFailure
{
    [self networkLoadFailureWithImage:nil];
}

- (void)networkLoadFailureWithImage:(UIImage *)image
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self p_setMessage:@"网络不给力\n请查看网络设置或稍后重试" icon:image?:[UIImage imageNamed:@"net-fail"]];
    _reloadButton.hidden = NO;
    
}

- (void)noMessageWithMessage:(NSString *)message image:(UIImage *)image
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self p_setMessage:message?:@"" icon:image?:[UIImage imageNamed:@""]];
    _reloadButton.hidden = YES;
}

#pragma mark - action

- (void)p_didTapReloadButton:(id)sender
{
    [self startLoading];
    if ( self. reloadBlock ){
        self.reloadBlock(nil);
    }
}

#pragma mark - deallco

- (void)dealloc
{
    if ( _loadingAnimation ){
        [_loadingAnimation stopAnimation];
    }
}

@end
