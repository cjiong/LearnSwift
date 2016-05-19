//
//  DIOpenSDKRegisterOptions.h
//  DIOpenSDK
//
//  Created by gr4yk3r on 15/10/14.
//  Copyright © 2015年 com.xiaojukeji.didiOpenSdk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIOpenSDKRegisterOptions : NSObject

@property (nonatomic, copy) NSString *fromlat;      //出发地纬度
@property (nonatomic, copy) NSString *fromlng;      //出发地经度
@property (nonatomic, copy) NSString *fromaddr;     //出发地地址
@property (nonatomic, copy) NSString *fromname;     //出发地名称
@property (nonatomic, copy) NSString *tolat;        //目的地纬度
@property (nonatomic, copy) NSString *tolng;        //目的地经度
@property (nonatomic, copy) NSString *toaddr;       //目的地地址
@property (nonatomic, copy) NSString *toname;       //目的地名称
@property (nonatomic, copy) NSString *phone;        //乘客手机号，方便乘客登录使用，会默认补全到登录框中
@property (nonatomic, copy) NSString *biz;	        //1 出租车，2 专车，3 快车，4 代驾，5 顺风车
@property (nonatomic, copy) NSString *maptype;	    //经纬度类型 wgs84/baidu/soso

@end
