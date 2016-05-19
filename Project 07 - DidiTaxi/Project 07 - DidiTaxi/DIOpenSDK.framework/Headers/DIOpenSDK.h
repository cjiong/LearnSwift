//
//  DIOpenSDK.h
//  DIOpenSDK
//
//  Created by gr4yk3r on 15/10/13.
//  Copyright © 2015年 com.xiaojukeji.didiOpenSdk. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <DIOpenSDK/DIOpenSDKRegisterOptions.h>

@protocol DIOpenSDKDelegate <NSObject>
// 打车页面关闭回调
- (void)pageClose;
@end

@interface DIOpenSDK : NSObject

/**
 *  注册app
 *
 *  @param appId  开发者网站申请的appid
 *  @param secret 开发者网站申请的secret
 */
+ (void)registerApp:(NSString *)appId secret:(NSString *)secret;

/**
 *  通过该方法调起滴滴页面
 *
 *  @param parentController 展现滴滴页面的ViewController
 *  @param animated         展现滴滴页面时是否需要动画
 *  @param optionParams     可选参数
 *  @param delegate         代理
 */
+ (void)showDDPage:(UIViewController *)parentController
          animated:(BOOL)animated
          params:(DIOpenSDKRegisterOptions *)optionParams
          delegate:(id<DIOpenSDKDelegate>)delegate;

@end
