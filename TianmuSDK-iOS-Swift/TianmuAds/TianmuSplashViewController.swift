//
//  TianmuSplashViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit

class TianmuSplashViewController: BaseViewController, TianmuSplashAdDelegate {

    var splash: TianmuSplashAd?
    var bottomView: UIView?
    var isHeadBidding: Bool = false
    var isSucceed: Bool = false
    var fullBool: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 225/255.0, green: 233/255.0, blue: 239/255.0, alpha: 1)
        let loadBtn = UIButton.init()
        loadBtn.layer.cornerRadius = 3;
        loadBtn.clipsToBounds = true;
        loadBtn.backgroundColor = UIColor.white
        loadBtn.setTitle("开始询价", for: .normal)
        loadBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(loadBtn)
        loadBtn.frame = CGRect.init(x: 30, y: 100, width: UIScreen.main.bounds.size.width-60, height: 40)
        loadBtn.addTarget(self, action: #selector(loadBidAd), for: .touchUpInside)
        
        let bidWinBtn = UIButton.init()
        bidWinBtn.layer.cornerRadius = 3
        bidWinBtn.clipsToBounds = true
        bidWinBtn.backgroundColor = UIColor.white
        bidWinBtn.setTitle("竞价成功", for: .normal)
        bidWinBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(bidWinBtn)
        bidWinBtn.frame = CGRect.init(x: 30, y: 160, width: UIScreen.main.bounds.size.width-60, height: 40)
        bidWinBtn.addTarget(self, action: #selector(bidWin), for: .touchUpInside)
        
        let bidFailBtn = UIButton.init()
        bidFailBtn.layer.cornerRadius = 3
        bidFailBtn.clipsToBounds = true
        bidFailBtn.backgroundColor = UIColor.white
        bidFailBtn.setTitle("竞价失败", for: .normal)
        bidFailBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(bidFailBtn)
        bidFailBtn.frame = CGRect.init(x: 30, y: 220, width: UIScreen.main.bounds.size.width-60, height: 40)
        bidFailBtn.addTarget(self, action: #selector(bidFail), for: .touchUpInside)
        
        let showBtn = UIButton.init()
        showBtn.layer.cornerRadius = 3
        showBtn.clipsToBounds = true
        showBtn.backgroundColor = UIColor.white
        showBtn.setTitle("正常加载展示", for: .normal)
        showBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(showBtn)
        showBtn.frame = CGRect.init(x: 30, y: 280, width: UIScreen.main.bounds.size.width-60, height: 40)
        showBtn.addTarget(self, action: #selector(loadSplashAd), for: .touchUpInside)
    
        // 4、初始化底部视图
        var bottomViewHeight:CGFloat = SCREEN_HEIGHT * 0.15
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - bottomViewHeight, width: SCREEN_WIDTH, height: bottomViewHeight))
        bottomView?.backgroundColor = UIColor.white
        
        let logoImageView = UIImageView.init(image: UIImage.init(named: "Tianmu_Logo.png"))
        logoImageView.frame = CGRect.init(x: (SCREEN_WIDTH - 135)/2, y: (bottomViewHeight - 46)/2, width: 135, height: 46)
        
        bottomView?.addSubview(logoImageView)
       
        // Do any additional setup after loading the view.
       
    }
    @objc func loadBidAd(){
        isHeadBidding = true
        isSucceed = false
        splash = TianmuSplashAd.init()
        splash?.posId = "e815b3c6d02a"
        splash!.delegate = self
        let bgImage = UIImage.init(named: "750x1334.png")
        splash?.backgroundColor = UIColor.adsy_get(with:bgImage!, withNewSize: UIScreen.main.bounds.size)
        splash?.load(withBottomView: fullBool ? nil : bottomView)
    }
    @objc func bidWin(){
        if !isHeadBidding {
            self.view.makeToast("当前广告不是竞价广告")
        }
        if !isSucceed || splash == nil{
            self.view.makeToast("开屏广告未加载成功")
            return
        }
        splash?.sendWinNotification(withPrice: (splash?.bidFloor())!)
        splash?.show(in: UIApplication.shared.keyWindow!)
    }
    @objc func bidFail(){
        if !isHeadBidding {
            self.view.makeToast("当前广告不是竞价广告")
        }
        if !isSucceed || splash == nil{
            self.view.makeToast("开屏广告未加载成功")
            return
        }
        let otherPlatPrice : Int = 100
        splash?.sendWinFailNotificationReason(.lowPrice, winnerPirce: otherPlatPrice)
        
        splash?.show(in: UIApplication.shared.keyWindow!)
    }
    @objc func loadSplashAd() {
        isHeadBidding = false
        isSucceed = false
        splash = TianmuSplashAd.init()
        splash?.posId = "0b815e3cda9f"
        splash!.delegate = self
        let bgImage = UIImage.init(named: "750x1334.png")
        splash?.backgroundColor = UIColor.adsy_get(with:bgImage!, withNewSize: UIScreen.main.bounds.size)
        splash?.loadAndShow(in: UIApplication.shared.keyWindow!, withBottomView: fullBool ? nil : bottomView)
    }
    /**
     *  开屏广告请求成功
     */
    func tianmuSplashAdSuccessLoad(_ splashAd: TianmuSplashAd) {
        isSucceed = true
        if isHeadBidding {
            self.view.makeToast("当前广告价格： \(splashAd.bidPrice())")
        }
    }
    /**
     *  开屏广告素材加载成功
     */
    func tianmuSplashAdDidLoad(_ splashAd: TianmuSplashAd) {
        
    }
    /**
     *  开屏广告展示失败
     */
    func tianmuSplashAdFailToShow(_ splashAd: TianmuSplashAd) {
        self.view.makeToast("开屏广告展示失败")
    }
    /**
     *  开屏广告曝光回调
     */
    func tianmuSplashAdExposured(_ splashAd: TianmuSplashAd) {
        
    }
    /**
     *  开屏广告请求失败
     */
    func tianmuSplashAdFailLoad(_ splashAd: TianmuSplashAd, withError error: Error) {
        print(error)
        splash = nil
    }
    /**
     *  开屏广告展示失败
     */
    func tianmuSplashAdRenderFaild(_ splashAd: TianmuSplashAd, withError error: Error) {
        self.view.makeToast("开屏广告渲染失败")
        isSucceed = false
    }
    /**
     *  开屏广告点击回调
     */
    func tianmuSplashAdClicked(_ splashAd: TianmuSplashAd) {
        
    }
    /**
     *  开屏广告关闭回调
     */
    func tianmuSplashAdClosed(_ splashAd: TianmuSplashAd) {
        splash = nil
    }
    /**
     *  开屏广告倒计时结束回调
     */
    func tianmuSplashAdCountdown(_ splashAd: TianmuSplashAd) {
        
    }
    /**
     *  开屏广告点击跳过回调
     */
    func tianmuSplashAdSkiped(_ splashAd: TianmuSplashAd) {
        
    }
    /**
     *  开屏广告关闭落地页回调
     */
    func tianmuSplashAdCloseLandingPage(_ splashAd: TianmuSplashAd) {
        
    }
}
