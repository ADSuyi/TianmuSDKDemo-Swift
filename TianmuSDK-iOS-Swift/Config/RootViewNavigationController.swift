//
//  RootViewNavigationController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit

class RootViewNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance.configureWithOpaqueBackground()
            navigationBar.standardAppearance.backgroundColor = UIColor(red: 36 / 255.0, green: 132 / 255.0, blue: 207 / 255.0, alpha: 1)
            navigationBar.standardAppearance.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }else{
            navigationBar.barTintColor = UIColor(red: 36 / 255.0, green: 132 / 255.0, blue: 207 / 255.0, alpha: 1)
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        }
        
    }
    

}
