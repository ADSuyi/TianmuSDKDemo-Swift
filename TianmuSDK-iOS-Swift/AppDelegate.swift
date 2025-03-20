//
//  AppDelegate.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit
import AppTrackingTransparency
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate, TianmuSplashAdDelegate {

    var window: UIWindow?
    var splash: TianmuSplashAd?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        window?.backgroundColor = .white
        window?.rootViewController = RootViewNavigationController.init(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        
        self.setThirtyPartySdk()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // 热启动进入前台 加载广告
        self.loadSplash()
       
    }
    
    func setThirtyPartySdk() {
        if isFirstLoad() {
            self.showAgreePrivacy()
        }else{
            self.initTianmuSDK()
        }
    }

    func initTianmuSDK() {
        TianmuSDK.enablePersonalInformation = true
        TianmuSDK.initWithAppId("1001006") { error in
            if (error != nil) {
                print("初始化失败")
            }else{
                print("初始化成功")
            }
        }
       
        loadSplash()
    }
    
    func loadSplash(){
        if splash != nil {
            return
        }
        // 4、初始化底部视图
        var bottomViewHeight:CGFloat = SCREEN_HEIGHT * 0.15
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - bottomViewHeight, width: SCREEN_WIDTH, height: bottomViewHeight))
        bottomView.backgroundColor = UIColor.white
        
        let logoImageView = UIImageView.init(image: UIImage.init(named: "Tianmu_Logo.png"))
        logoImageView.frame = CGRect.init(x: (SCREEN_WIDTH - 135)/2, y: (bottomViewHeight - 46)/2, width: 135, height: 46)
        
        bottomView.addSubview(logoImageView)
        // Do any additional setup after loading the view.
        
        splash = TianmuSplashAd.init()
        splash?.posId = "0b815e3cda9f"
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
        
    }
    
    func tianmuSplashAdClosed(_ splashAd: TianmuSplashAd) {
        splash = nil
    }
    
    func tianmuSplashAdCloseLandingPage(_ splashAd: TianmuSplashAd) {
        
    }

    
    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    
    // MARK: private method
    func showAgreePrivacy() {
        let alertVc = UIAlertController.init(title: "温馨提示", message: "亲爱的开发者，非常感谢您选择并选用天目Ads SDK！\n为了保证您的App顺利通过合规检测，本提示将向你演示天目Ads SDK初始化合规方案。\n1. APP首次运行时请通过弹窗等明显方式提示用户阅读《用户协议》和《隐私政策》，用户确认同意《用户协议》和《隐私政策》后，再启用SDK进行个人信息的收集与处理。\n2. 本提示的内容及《用户协议》和《隐私政策》需根据你的APP业务需求进行编写，可参考《网络安全标准实践指南—移动互联网应用程序（App）收集使用个人信息自评估指南》或咨询对接人员。\n你可以通过阅读完整版的ADmobile 《用户协议》和《隐私政策》了解ADmobile详细隐私策略", preferredStyle: UIAlertController.Style.alert)
        
        let cancle = UIAlertAction.init(title: "不同意", style: UIAlertAction.Style.cancel) { [self] (action) in
            let alert = UIAlertController.init(title: "", message: "点击同意才能使用该App服务", preferredStyle: UIAlertController.Style.alert)
            let sure = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default) { [self] (action) in
                window?.rootViewController?.present(alertVc, animated:true, completion: nil)
            }
            alert.addAction(sure)
            window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        let agree = UIAlertAction.init(title: "同意并继续", style: UIAlertAction.Style.default) { (action) in
            // 记录是否第一次启动
            self.writeAppLoad()
            //        获取idfa权限 建议获取idfa，否则会影响收益
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { (status) in
                    
                }
            }
            // 用户同意协议 初始化
            self.initTianmuSDK()
        }
        let userLink = UIAlertAction.init(title: "《用户协议》", style: UIAlertAction.Style.destructive) { (action) in
            self.openLinkURL("https://doc.admobile.top/ssp/pages/contract/")
        }
        let privacyLink = UIAlertAction.init(title: "《隐私政策》", style: UIAlertAction.Style.destructive) { (action) in
            self.openLinkURL("https://www.admobile.top/privacyPolicy.html")
        }
        
        alertVc.addAction(cancle)
        alertVc.addAction(agree)
        alertVc.addAction(userLink)
        alertVc.addAction(privacyLink)
        window?.rootViewController?.present(alertVc, animated: true, completion: nil)
        
    }
    
    func openLinkURL(_ linkURL: String) {
        UIApplication.shared.open(URL(string: linkURL)!)
        self.showAgreePrivacy()
    }
   
    
    func writeAppLoad() {
        let userDefault = UserDefaults.standard
        userDefault.set("yes", forKey: "isFirstLoad")
        userDefault.synchronize()
    }
    
    func isFirstLoad() -> Bool {
        let userDefault = UserDefaults.standard
        if (userDefault.object(forKey: "isFirstLoad") != nil)  {
            return false
        }
        return true
    }

}

