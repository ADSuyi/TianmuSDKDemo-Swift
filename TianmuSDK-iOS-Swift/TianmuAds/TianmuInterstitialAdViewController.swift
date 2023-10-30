//
//  TianmuInterstitialAdViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit

class TianmuInterstitialAdViewController: BaseViewController, TianmuInterstitialAdDelegate {

    var interstitialAd: TianmuInterstitialAd?
    var isReady:Bool = false
    var isNormalAd:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 225/255.0, green: 233/255.0, blue: 239/255.0, alpha: 1)

        // Do any additional setup after loading the view.
        let loadBtn = UIButton.init()
        loadBtn.layer.cornerRadius = 3;
        loadBtn.clipsToBounds = true;
        loadBtn.backgroundColor = UIColor.white
        loadBtn.setTitle("加载普通插屏", for: .normal)
        loadBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(loadBtn)
        loadBtn.frame = CGRect.init(x: 30, y: 100, width: UIScreen.main.bounds.size.width-60, height: 40)
        loadBtn.addTarget(self, action: #selector(loadInterstitialAd), for: .touchUpInside)
        
        let showBtn = UIButton.init()
        showBtn.layer.cornerRadius = 3
        showBtn.clipsToBounds = true
        showBtn.backgroundColor = UIColor.white
        showBtn.setTitle("展示普通插屏", for: .normal)
        showBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(showBtn)
        showBtn.frame = CGRect.init(x: 30, y: 160, width: UIScreen.main.bounds.size.width-60, height: 40)
        showBtn.addTarget(self, action: #selector(showInterstitialAd), for: .touchUpInside)
        
        let loadBidBtn = UIButton.init()
        loadBidBtn.layer.cornerRadius = 3
        loadBidBtn.clipsToBounds = true
        loadBidBtn.backgroundColor = UIColor.white
        loadBidBtn.setTitle("加载竞价插屏", for: .normal)
        loadBidBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(loadBidBtn)
        loadBidBtn.frame = CGRect.init(x: 30, y: 220, width: UIScreen.main.bounds.size.width-60, height: 40)
        loadBidBtn.addTarget(self, action: #selector(loadBidAd), for: .touchUpInside)
        
        let bidWinBtn = UIButton.init()
        bidWinBtn.layer.cornerRadius = 3
        bidWinBtn.clipsToBounds = true
        bidWinBtn.backgroundColor = UIColor.white
        bidWinBtn.setTitle("竞价成功", for: .normal)
        bidWinBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(bidWinBtn)
        bidWinBtn.frame = CGRect.init(x: 30, y: 280, width: UIScreen.main.bounds.size.width-60, height: 40)
        bidWinBtn.addTarget(self, action: #selector(bidWin), for: .touchUpInside)
        
        let bidFailBtn = UIButton.init()
        bidFailBtn.layer.cornerRadius = 3
        bidFailBtn.clipsToBounds = true
        bidFailBtn.backgroundColor = UIColor.white
        bidFailBtn.setTitle("竞价失败", for: .normal)
        bidFailBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(bidFailBtn)
        bidFailBtn.frame = CGRect.init(x: 30, y: 340, width: UIScreen.main.bounds.size.width-60, height: 40)
        bidFailBtn.addTarget(self, action: #selector(bidFail), for: .touchUpInside)
    
        
    }
    
    @objc func loadInterstitialAd() {
        isNormalAd = true;
        isReady = false
        // 1、初始化插屏广告对象
        interstitialAd = TianmuInterstitialAd.init()
        interstitialAd!.delegate = self
        interstitialAd!.controller = self
        interstitialAd!.posId = "682f5d1cb439"
        // 是否开启倒计时关闭
        // interstitialAd?.isAutoClose = true
        // 设置倒计时关闭时长 [3~100) 区间内有效
        // interstitialAd?.autoCloseTime = 10
        // 2、加载插屏广告
        interstitialAd?.loadData()
    }
    
    @objc func showInterstitialAd() {
        if isReady && (interstitialAd != nil) {
            interstitialAd?.show(fromRootViewController: self)
        }else {
            self.view.makeToast("插屏广告未准备完成")
        }
    }
    
    @objc func loadBidAd(){
        isNormalAd = false
        isReady = false
        // 1、初始化插屏广告对象
        interstitialAd = TianmuInterstitialAd.init()
        interstitialAd!.delegate = self
        interstitialAd!.controller = self
        interstitialAd!.posId = "03bd2a589fe1"
        // 2、加载插屏广告
        interstitialAd?.loadData()
    }
    
    @objc func bidWin(){
        if (isNormalAd){
            self.view.makeToast("当前广告不是竞价广告")
            return;
        }
        if isReady && (interstitialAd != nil) {
            interstitialAd?.sendWinNotification(withPrice: (interstitialAd?.bidFloor())!)
            interstitialAd?.show(fromRootViewController: self)
            return
        }
        self.view.makeToast("广告未准备好")
    }
    
    @objc func bidFail(){
        if (isNormalAd){
            self.view.makeToast("当前广告不是竞价广告")
            return;
        }
        if isReady && (interstitialAd != nil){
            interstitialAd?.sendWinFailNotificationReason(.lowPrice, winnerPirce: 1000)
            interstitialAd?.show(fromRootViewController: self)
            return
        }
        self.view.makeToast("广告未准备好")
    }
    /**
     *  插屏广告数据请求成功
     */
    func tianmuInterstitialSuccess(toLoad unifiedInterstitial: TianmuInterstitialAd) {
        print(#function)
        // 3、展示插屏广告
        if !isNormalAd{
            self.view.makeToast("当前广告价格：\(unifiedInterstitial.bidPrice())")
        }
        isReady = true
        self.view.makeToast("广告准备好")
    }
    /**
     *  插屏广告渲染成功
     */
    func tianmuInterstitialRenderSuccess(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    /**
     *  插屏广告视图展示成功回调
     *  插屏广告展示成功回调该函数
     */
    func tianmuInterstitialDidPresentScreen(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    /**
     *  插屏广告数据请求失败
     */
    func tianmuInterstitialFail(toLoad unifiedInterstitial: TianmuInterstitialAd, error: Error) {
        print(#function)
        self.view.makeToast("\(error)")
        interstitialAd = nil
    }
    /**
     *  插屏广告视图展示失败回调
     *  插屏广告展示失败回调该函数
     */
    func tianmuInterstitialFail(toPresent unifiedInterstitial: TianmuInterstitialAd, error: Error) {
        print(#function)
        self.view.makeToast("当前广告展示失败：\(error)")
        interstitialAd = nil
    }
    
    /**
     *  插屏广告曝光回调
     */
    func tianmuInterstitialWillExposure(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    /**
     *  插屏广告点击回调
     */
    func tianmuInterstitialClicked(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    /**
     *  插屏广告页关闭
     */
    func tianmuInterstitialAdDidDismissClose(_ unifiedInterstitial: TianmuInterstitialAd) {
        self.interstitialAd = nil
    }

    /**
     插屏视频广告开始播放
     */
    func tianmuInterstitialAdVideoPlay(_ unifiedInterstitial: TianmuInterstitialAd){
        
    }
    /**
     插屏视频广告视频播放失败
     */
    func tianmuInterstitialAdVideoPlayFail(_ unifiedInterstitial: TianmuInterstitialAd, error: Error) {
        
    }
    /**
     插屏视频广告视频暂停
     */
    func tianmuInterstitialAdVideoPause(_ unifiedInterstitial: TianmuInterstitialAd){
        
    }
    /**
     插屏视频广告视频播放完成
     */
    func tianmuInterstitialAdVideoFinish(_ unifiedInterstitial: TianmuInterstitialAd){
        
    }
    
    func tianmuInterstitialAdDidCloseLandingPage(_ unifiedInterstitial: TianmuInterstitialAd){
        
    }
}
