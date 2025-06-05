//
//  TianmuBannderViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit

class TianmuBannderViewController: BaseViewController, TianmuBannerAdViewDelegate {
    
    var bannerAdView : TianmuBannerAdView?
    var isHeadBidding: Bool = false
    var isSucceed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let margin = self.view.bounds.size.width/5.0 - 320.0/5.0
        
        let loadAndShowBtn = UIButton.init()
        loadAndShowBtn.setTitle("普通请求", for: UIControl.State.normal)
        loadAndShowBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loadAndShowBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loadAndShowBtn.backgroundColor = UIColor.lightGray
        loadAndShowBtn.clipsToBounds = true
        loadAndShowBtn.layer.cornerRadius = 3
        loadAndShowBtn.addTarget(self, action: #selector(loadNomarlAd), for: UIControl.Event.touchUpInside)
        loadAndShowBtn.frame = CGRect.init(x: margin, y: self.view.bounds.size.height - 60, width: 80, height: 30)
        self.view.addSubview(loadAndShowBtn)
        self.view.bringSubviewToFront(loadAndShowBtn)
        
        let loadBtn = UIButton.init()
        loadBtn.setTitle("竞价请求", for: UIControl.State.normal)
        loadBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loadBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loadBtn.backgroundColor = UIColor.lightGray
        loadBtn.clipsToBounds = true
        loadBtn.layer.cornerRadius = 3
        loadBtn.addTarget(self, action:#selector(loadBidAd), for: UIControl.Event.touchUpInside)
        loadBtn.frame = CGRect.init(x: margin*2 + 80, y: self.view.bounds.size.height - 60, width: 80, height: 30)
        self.view.addSubview(loadBtn)
        self.view.bringSubviewToFront(loadBtn)
        
        let bidWinBtn = UIButton.init()
        bidWinBtn.setTitle("竞价成功", for: UIControl.State.normal)
        bidWinBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bidWinBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bidWinBtn.backgroundColor = UIColor.lightGray
        bidWinBtn.clipsToBounds = true
        bidWinBtn.layer.cornerRadius = 3
        bidWinBtn.addTarget(self, action: #selector(bidWin), for: UIControl.Event.touchUpInside)
        bidWinBtn.frame = CGRect.init(x: 160 + margin*3, y: self.view.bounds.size.height - 60, width: 80, height: 30)
        self.view.addSubview(bidWinBtn)
        self.view.bringSubviewToFront(bidWinBtn)
        
        let bidFailBtn = UIButton.init()
        bidFailBtn.setTitle("竞价失败", for: UIControl.State.normal)
        bidFailBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bidFailBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bidFailBtn.backgroundColor = UIColor.lightGray;
        bidFailBtn.clipsToBounds = true
        bidFailBtn.layer.cornerRadius = 3
        bidFailBtn.addTarget(self, action: #selector(bidFail), for: UIControl.Event.touchUpInside)
        bidFailBtn.frame = CGRect.init(x: margin*4 + 240, y: self.view.bounds.size.height - 60, width: 80, height: 30)
        self.view.addSubview(bidFailBtn)
        self.view.bringSubviewToFront(bidFailBtn)
    }
   
    @objc func loadNomarlAd() {
        isHeadBidding = false
        isSucceed = false
        let frame = CGRect(x: 0, y: 250, width: SCREEN_WIDTH, height: SCREEN_WIDTH / (640/100.0))
        bannerAdView = createBannerAdView(frame: frame, posId: "e592f0da3b71")
        bannerAdView?.loadRequest()
    }

    @objc func loadBidAd() {
        isHeadBidding = true
        isSucceed = true
        let frame = CGRect(x: 0, y: 250, width: SCREEN_WIDTH, height: SCREEN_WIDTH / (640/100.0))
        bannerAdView = createBannerAdView(frame: frame, posId: "9012784e6c3b")
        bannerAdView?.loadRequest()
    }
    
    @objc func bidWin(){
        if !isHeadBidding {
            self.view.makeToast("当前广告不是竞价广告")
        }
        if !isSucceed || bannerAdView == nil{
            self.view.makeToast("开屏广告未加载成功")
            return
        }
        bannerAdView?.sendWinNotification(withPrice: (bannerAdView?.bidFloor())!)
        
    }
    @objc func bidFail(){
        if !isHeadBidding {
            self.view.makeToast("当前广告不是竞价广告")
        }
        if !isSucceed || bannerAdView == nil{
            self.view.makeToast("开屏广告未加载成功")
            return
        }
        bannerAdView?.sendWinFailNotificationReason(TianmuAdBiddingLossReason.other, winnerPirce: 100)
    }
    
    func createBannerAdView(frame: CGRect, posId: String) -> TianmuBannerAdView {
        let bannerAdView = TianmuBannerAdView(frame: frame, posId: posId)
        bannerAdView.delegate = self
        bannerAdView.viewController = self
        self.view.addSubview(bannerAdView)
        return bannerAdView
    }
    
    /**
     *  请求广告条数据成功后调用
     *  当接收服务器返回的广告数据成功后调用该函数
     */
    func tianmuBannerSuccessLoad(_ tianmuBannerView: TianmuBannerAdView) {
        // 重要‼️ 如果是竞价广告位，且支持自刷新，需要处理自刷新的竟赢上报
        isSucceed = true
        if isHeadBidding {
            self.view.makeToast("当前广告价格： \(tianmuBannerView.bidPrice())")
        }
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
