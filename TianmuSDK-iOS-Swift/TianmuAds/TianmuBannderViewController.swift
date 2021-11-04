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

        // Do any additional setup after loading the view.
        
        bannerAdView = TianmuBannerAdView.init(frame: CGRect.init(x: 0, y: 250, width: SCREEN_WIDTH, height: SCREEN_WIDTH / (640/100.0)), posId: "6c8a713efb95")
        bannerAdView!.delegate = self
        bannerAdView?.viewController = self
        self.view.addSubview(bannerAdView!)
        bannerAdView?.loadRequest()
    }
    
    
    
    func tianmuBannerSuccessLoad(_ tianmuBannerView: TianmuBannerAdView) {
        
    }
    
    func tianmuBannerViewFailedToLoadWithError(_ error: Error) {
        bannerAdView?.removeFromSuperview()
        bannerAdView = nil
    }
    
    func tianmuBannerViewWillExpose(_ tianmuBannerView: TianmuBannerAdView) {
        
    }

    func tianmuBannerViewClicked(_ tianmuBannerView: TianmuBannerAdView) {
        
    }
    
    func tianmuBannerViewWillClose(_ tianmuBannerView: TianmuBannerAdView) {
        bannerAdView?.removeFromSuperview()
        bannerAdView = nil
    }
   
}
