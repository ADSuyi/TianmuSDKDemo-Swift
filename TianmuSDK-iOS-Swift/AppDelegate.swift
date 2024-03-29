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
        splash = nil
    }
    
    func tianmuSplashAdClosed(_ splashAd: TianmuSplashAd) {
        splash = nil
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
        let alertVc = UIAlertController.init(title: "温馨提示", message: "亲爱的用户，欢迎您信任并使用【】，我们依据相关法律制定了《用户协议》和《隐私协议》帮你你了解我们手机，使用，存储和共享个人信息情况，请你在点击之前仔细阅读并理解相关条款。\n1、在使用我们的产品和服务时，将会提供与具体功能有关的个法人信息（可能包括身份验证，位置信息，设备信息和操作日志等）\n2、我们会采用业界领先的安全技术来保护你的个人隐私，未经授权许可我们不会讲上述信息共享给任何第三方或用于未授权的其他用途。\n如你同意请点击同意按钮并继续。", preferredStyle: UIAlertController.Style.alert)
        
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
        
        alertVc.addAction(cancle)
        alertVc.addAction(agree)
        window?.rootViewController?.present(alertVc, animated: true, completion: nil)
        
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

