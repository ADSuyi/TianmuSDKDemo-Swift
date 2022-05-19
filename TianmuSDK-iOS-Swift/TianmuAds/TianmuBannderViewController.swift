//
//  TianmuBannderViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit

class TianmuBannderViewController: BaseViewController, TianmuBannerAdViewDelegate {
    
    var bannerAdView : TianmuBannerAdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerAdView = TianmuBannerAdView.init(frame: CGRect.init(x: 0, y: 250, width: SCREEN_WIDTH, height: SCREEN_WIDTH / (640/100.0)), posId: "e592f0da3b71")
        bannerAdView!.delegate = self
        bannerAdView?.viewController = self
        self.view.addSubview(bannerAdView!)
        bannerAdView?.loadRequest()
    }
    
    /**
     *  请求广告条数据成功后调用
     *  当接收服务器返回的广告数据成功后调用该函数
     */
    func tianmuBannerSuccessLoad(_ tianmuBannerView: TianmuBannerAdView) {
        
    }
    
    /**
     *  请求广告数据失败后调用
     *  当接收服务器返回的广告数据失败后调用该函数
     */
    func tianmuBannerViewFailedToLoadWithError(_ error: Error) {
        print(error)
        bannerAdView?.removeFromSuperview()
        bannerAdView = nil
    }
    /**
     *  曝光回调
     */
    func tianmuBannerViewWillExpose(_ tianmuBannerView: TianmuBannerAdView) {
        
    }
    /**
     *  点击回调
     */
    func tianmuBannerViewClicked(_ tianmuBannerView: TianmuBannerAdView) {
        
    }
    
    /**
     *  被用户关闭时调用
     */
    func tianmuBannerViewWillClose(_ tianmuBannerView: TianmuBannerAdView) {
        bannerAdView?.removeFromSuperview()
        bannerAdView = nil
    }
    /**
     *  关闭落地页
     */
    func tianmuBannerViewCloseLandingPage(_ tianmuBannerView: TianmuBannerAdView) {
        
    }
    
}
