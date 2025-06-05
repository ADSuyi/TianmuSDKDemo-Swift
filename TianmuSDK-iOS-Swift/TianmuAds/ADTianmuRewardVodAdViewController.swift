//
//  ADTianmuRewardVodAdViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 李上京 on 2022/5/19.
//

import UIKit

class ADTianmuRewardVodAdViewController: BaseViewController, TianmuRewardVodAdDelegate {

    var rewardVodAd: TianmuRewardVodAd?
    var isReady:Bool = false
    var isNormalAd:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 225/255.0, green: 233/255.0, blue: 239/255.0, alpha: 1)
        
        let loadBtn = UIButton.init()
        loadBtn.layer.cornerRadius = 3;
        loadBtn.clipsToBounds = true;
        loadBtn.backgroundColor = UIColor.white
        loadBtn.setTitle("加载普通激励视频", for: .normal)
        loadBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(loadBtn)
        loadBtn.frame = CGRect.init(x: 30, y: 100, width: UIScreen.main.bounds.size.width-60, height: 40)
        loadBtn.addTarget(self, action: #selector(loadRewardVodAd), for: .touchUpInside)
        
        let showBtn = UIButton.init()
        showBtn.layer.cornerRadius = 3
        showBtn.clipsToBounds = true
        showBtn.backgroundColor = UIColor.white
        showBtn.setTitle("展示普通激励视频", for: .normal)
        showBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(showBtn)
        showBtn.frame = CGRect.init(x: 30, y: 160, width: UIScreen.main.bounds.size.width-60, height: 40)
        showBtn.addTarget(self, action: #selector(showRewardVodAd), for: .touchUpInside)
        
        let loadBidBtn = UIButton.init()
        loadBidBtn.layer.cornerRadius = 3
        loadBidBtn.clipsToBounds = true
        loadBidBtn.backgroundColor = UIColor.white
        loadBidBtn.setTitle("加载竞价激励视频", for: .normal)
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
    
    @objc func loadRewardVodAd(){
        isNormalAd = true
        isReady = false
        rewardVodAd = TianmuRewardVodAd.init()
        rewardVodAd!.delegate = self
        rewardVodAd!.controller = self
        rewardVodAd!.posId = "31dab847fc60"
        rewardVodAd?.loadData()
    }
    
    @objc func showRewardVodAd(){
        if (!isReady) {
            self.view.makeToast("广告未准备好")
            return;
        }
        self.rewardVodAd?.show(fromRootViewController: self)
    }

    @objc func loadBidAd(){
        isNormalAd = false
        isReady = false
        rewardVodAd = TianmuRewardVodAd.init()
        rewardVodAd?.delegate = self
        rewardVodAd?.controller = self
        rewardVodAd?.posId = "bd470c31f968";
        rewardVodAd?.loadData()
    }

    @objc func bidWin(){
        if (isNormalAd){
            self.view.makeToast("当前广告不是竞价广告")
            return;
        }
        if (isReady && (self.rewardVodAd != nil)) {
            self.rewardVodAd?.sendWinNotification(withPrice: (rewardVodAd?.bidFloor())!);
            rewardVodAd?.show(fromRootViewController: self)
            return;
        }
        self.view.makeToast("广告未准备好")
    }

    @objc func bidFail(){
        if (isNormalAd){
            self.view.makeToast("当前广告不是竞价广告")
            return;
        }
        if (isReady && (self.rewardVodAd != nil)) {
            self.rewardVodAd?.sendWinFailNotificationReason(.lowPrice, winnerPirce: 1000)
            self.rewardVodAd?.show(fromRootViewController: self)
            return;
        }
        self.view.makeToast("广告未准备好")
    }
    


    // MARK: TianmuRewardVodAdDelegate

    /**
     *  激励视频广告数据请求成功
     */
    func tianmuRewardVodAdSuccess(toLoad rewardVodAd: TianmuRewardVodAd) {
        if (!isNormalAd){
            self.view.makeToast("当前广告价格：\(rewardVodAd.bidPrice())")
        }
    }

    /**
     *  激励视频广告数据请求失败
     */
    func tianmuRewardVodAdFail(toLoad rewardVodAd: TianmuRewardVodAd, error: Error) {
        print("激励视频请求失败===\(error)")
    }

    /**
     *  激励视频广告缓存成功
     */
    func tianmuRewardVodAdVideoCacheFinish(_ rewardVodAd: TianmuRewardVodAd) {
        print("激励视频缓存成功");
    }

    /**
     *  激励视频广告渲染成功
     *  建议在此回调后展示广告
     */
    func tianmuRewardVodAdVideoReady(toPlay rewardVodAd: TianmuRewardVodAd) {
        isReady = true;
        self.view.makeToast("广告准备好")
    }

    /**
     *  激励视频广告播放失败
     *
     */
    func tianmuRewardVodAdVideoPlayFail(_ rewardVodAd: TianmuRewardVodAd, error: Error) {
        print("激励视频播放失败\(error)");
    }

    /**
     *  激励视频视图展示成功回调
     *  激励视频展示成功回调该函数
     */
    func tianmuRewardVodAdDidPresentScreen(_ rewardVodAd: TianmuRewardVodAd) {
        
    }
        
    /**
     *  激励视频广告视图展示失败回调
     *  激励视频广告展示失败回调该函数
     */
    func tianmuRewardVodAdFail(toPresent rewardVodAd: TianmuRewardVodAd, error: Error) {
        self.view.makeToast("当前广告展示失败\(error)")
    }

    /**
     *  激励视频广告曝光回调
     */
    func tianmuRewardVodAdWillExposure(_ rewardVodAd: TianmuRewardVodAd) {
        print("激励视频曝光")
    }

    /**
     *  激励视频广告点击回调
     */
    func tianmuRewardVodAdClicked(_ rewardVodAd: TianmuRewardVodAd) {
        print("激励视频点击")
    }

    /**
     *  激励视频广告页关闭
     */
    func tianmuRewardVodAdAdDidDismissClose(_ rewardVodAd: TianmuRewardVodAd) {
        self.rewardVodAd = nil
    }

    /**
     *  激励视频广告达到激励条件
     */
    func tianmuRewardVodAdAdDidEffective(_ rewardVodAd: TianmuRewardVodAd) {
        print("激励视频达到激励条件")
    }

    func tianmuRewardVodAdAdVideoPlayFinish(_ rewardVodAd: TianmuRewardVodAd) {
        print("激励视频播放完成")
    }

    func tianmuRewardVodAdCloseLandingPage(_ rewardVodAd: TianmuRewardVodAd) {
        
    }
}
