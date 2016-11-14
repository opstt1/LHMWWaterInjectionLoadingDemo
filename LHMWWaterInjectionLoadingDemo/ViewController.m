//
//  ViewController.m
//  LHMWWaterInjectionLoadingDemo
//
//  Created by LiHaomiao on 2016/11/14.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LoadingView *loadingView = [LoadingView addToSuperView:self.view Frame:self.view.bounds];
    [loadingView startLoading];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
