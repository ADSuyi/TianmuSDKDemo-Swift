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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 225/255.0, green: 233/255.0, blue: 239/255.0, alpha: 1)

        // Do any additional setup after loading the view.
        let loadBtn = UIButton.init()
        loadBtn.layer.cornerRadius = 3;
        loadBtn.clipsToBounds = true;
        loadBtn.backgroundColor = UIColor.white
        loadBtn.setTitle("加载激励视频", for: .normal)
        loadBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(loadBtn)
        loadBtn.frame = CGRect.init(x: 30, y: UIScreen.main.bounds.size.height/2-60, width: UIScreen.main.bounds.size.width-60, height: 40)
        loadBtn.addTarget(self, action: #selector(loadInterstitialAd), for: .touchUpInside)
        
        let showBtn = UIButton.init()
        showBtn.layer.cornerRadius = 3
        showBtn.clipsToBounds = true
        showBtn.backgroundColor = UIColor.white
        showBtn.setTitle("展示激励视频", for: .normal)
        showBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(showBtn)
        showBtn.frame = CGRect.init(x: 30, y: UIScreen.main.bounds.size.height/2+20, width: UIScreen.main.bounds.size.width-60, height: 40)
        showBtn.addTarget(self, action: #selector(showInterstitialAd), for: .touchUpInside)
    }
    
    @objc func loadInterstitialAd() {
        // 1、初始化插屏广告对象
        interstitialAd = TianmuInterstitialAd.init()
        interstitialAd!.delegate = self
        interstitialAd!.controller = self
        interstitialAd!.posId = "418f6bdc0a3e"
        // 2、加载插屏广告
        interstitialAd?.loadData()
    }
    
    @objc func showInterstitialAd() {
        if isReady  {
            interstitialAd?.show(fromRootViewController: self)
        }else {
            self.view.makeToast("插屏广告未准备完成")
        }
    }
    
    func tianmuInterstitialSuccess(toLoad unifiedInterstitial: TianmuInterstitialAd) {
        print(#function)
        // 3、展示插屏广告
        isReady = true
        self.view.makeToast("插屏广告准备完成")
    }
    
    func tianmuInterstitialRenderSuccess(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    func tianmuInterstitialFail(toLoad unifiedInterstitial: TianmuInterstitialAd, error: Error) {
        print(#function)
        interstitialAd = nil
    }
    
    func tianmuInterstitialDidPresentScreen(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    func tianmuInterstitialWillExposure(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    func tianmuInterstitialClicked(_ unifiedInterstitial: TianmuInterstitialAd) {
        
    }
    
    func tianmuInterstitialAdDidDismissClose(_ unifiedInterstitial: TianmuInterstitialAd) {
        self.interstitialAd = nil
    }
    

}
