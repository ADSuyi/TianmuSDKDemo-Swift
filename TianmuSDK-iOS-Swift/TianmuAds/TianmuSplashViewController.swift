//
//  TianmuSplashViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit

class TianmuSplashViewController: BaseViewController, TianmuSplashAdDelegate {

    var splash: TianmuSplashAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 4、初始化底部视图
        var bottomViewHeight:CGFloat = 0
        if isIPhoneXSeries() {
            bottomViewHeight = SCREEN_WIDTH * 0.15
        } else {
            bottomViewHeight = SCREEN_HEIGHT - (SCREEN_WIDTH * 960 / 640)
        }
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - bottomViewHeight, width: SCREEN_WIDTH, height: bottomViewHeight))
        bottomView.backgroundColor = UIColor.white
        
        let logoImageView = UIImageView.init(image: UIImage.init(named: "Tianmu_Logo.png"))
        logoImageView.frame = CGRect.init(x: (SCREEN_WIDTH - 135)/2, y: (bottomViewHeight - 46)/2, width: 135, height: 46)
        
        bottomView.addSubview(logoImageView)
        // Do any additional setup after loading the view.
        
        splash = TianmuSplashAd.init()
        splash?.posId = "9106b5a8d273"
        splash!.delegate = self
        let bgImage = UIImage.init(named: "750x1334.png")
        splash?.backgroundColor = UIColor.adsy_get(with:bgImage!, withNewSize: UIScreen.main.bounds.size)
        splash?.loadAndShow(in: UIApplication.shared.keyWindow!, withBottomView: bottomView)
        
        
       
    }
    
    func tianmuSplashAdSuccessLoad(_ splashAd: TianmuSplashAd) {
        
    }
    
    func tianmuSplashAdExposured(_ splashAd: TianmuSplashAd) {
        
    }
    
    func tianmuSplashAdFailLoad(_ splashAd: TianmuSplashAd, withError error: Error) {
        print(error)
        splash = nil
    }
    
    func tianmuSplashAdRenderFaild(_ splashAd: TianmuSplashAd, withError error: Error) {
        
    }

    func tianmuSplashAdClicked(_ splashAd: TianmuSplashAd) {
        splash = nil
    }
    
    func tianmuSplashAdClosed(_ splashAd: TianmuSplashAd) {
        splash = nil
    }

}
