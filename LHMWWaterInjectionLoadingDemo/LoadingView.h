//
//  LoadingView.h
//  EmployeeAssistant
//
//  Created by LiHaomiao on 2016/10/10.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BaseLoadingView.h"

@interface LoadingView : BaseLoadingView

/**
 * 类方法，来初始化并且添加到需要添加的view里
 */
+ (LoadingView *)addToSuperView:(UIView *)superView Frame:(CGRect)frame;

@end
