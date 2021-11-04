//
//  TianmuSDKDemoTool.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit
// 屏幕宽高
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


// 设备
//适配iPhoneX
//获取状态栏的高度，全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt

//状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.height;

//导航栏高度
let navigationHeight = (statusBarHeight + 44)

//tabbar高度
let tabBarHeight = (statusBarHeight==44 ? 83 : 49)

//顶部的安全距离
let topSafeAreaHeight = (statusBarHeight - 20)

//底部的安全距离
let bottomSafeAreaHeight = (tabBarHeight - 49)


// 是否为刘海屏
func isIPhoneXSeries() ->Bool{
    var isIPhoneXSeries:Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return isIPhoneXSeries
    }
    
    if #available(iOS 11.0, *){
        
        let safeHeight:CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        
        if safeHeight > 0 {
            isIPhoneXSeries = true
        }
    }
    
    return isIPhoneXSeries
    
}

