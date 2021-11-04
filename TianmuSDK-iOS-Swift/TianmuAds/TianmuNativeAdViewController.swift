//
//  TianmuNativeAdViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit

class TianmuNativeAdViewController: BaseViewController, TianmuNativeExpressAdDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    let tableViewCellInentifier : String = "tableViewCellInentifier"
    let adTableViewCellInentifier : String = "adtableViewCellInentifier"


    var nativeAd: TianmuNativeExpressAd?
    var tableView: UITableView?
    private var dataArray:Array = Array<Any>.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        // Do any additional setup after loading the view.
        
        nativeAd = TianmuNativeExpressAd.init(adSize: CGSize.init(width: SCREEN_WIDTH, height: 10))
        nativeAd?.posId = "15c76f032d4b"
        nativeAd?.controller = self
        nativeAd!.delegate = self
        
    }
    

    func setUI(){
        tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.frame.origin.y = CGFloat(navigationHeight)
        tableView?.showsVerticalScrollIndicator = false
        tableView?.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            tableView?.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        tableView?.register(object_getClass(UITableViewCell()), forCellReuseIdentifier: tableViewCellInentifier)
        tableView?.register(object_getClass(UITableViewCell()), forCellReuseIdentifier:  adTableViewCellInentifier)
        self.view.addSubview(tableView!)
        
        tableView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.cleanAllAd()
            self.nativeAd?.load(withCount: 3)
        })
        
        tableView?.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.nativeAd?.load(withCount: 3)
        })
        
        tableView?.mj_header?.beginRefreshing()
    }
    
   
    // 模板信息流广告加载成功
    func tianmuExpressAdSucceed(toLoad expressAd: TianmuNativeExpressAd, views: [TianmuNativeExpressView]) {
        for adView in views {
            adView.tianmu_registViews([adView])
        }
        tableView?.mj_header?.endRefreshing()
        tableView?.mj_footer?.endRefreshing()

    }
    //渲染成功
    func tianmuExpressAdRenderSucceed(_ expressAd: TianmuNativeExpressAd, adView expressAdView: TianmuNativeExpressView) {
        DispatchQueue.main.async { [self] in
            for _ in 0...6 {
                self.dataArray.append(NSNull.init())
            }
            self.dataArray.append(expressAdView)
            tableView?.reloadData()
        }
    }
    
    func tianmuExpressAdFail(toLoad expressAd: TianmuNativeExpressAd, error: Error) {
        tableView?.mj_header?.endRefreshing()
        tableView?.mj_footer?.endRefreshing()
    }
    
    func tianmuExpressAdRenderFail(_ expressAd: TianmuNativeExpressView, error: Error) {
        
    }
    
    func tianmuExpressAdClosed(_ expressAd: TianmuNativeExpressAd, adView expressAdView: TianmuNativeExpressView) {
        dataArray.removeAll()
        tableView?.reloadData()
    }
    
    func tianmuExpressAdClick(_ expressAd: TianmuNativeExpressAd, adView expressAdView: TianmuNativeExpressView) {
        
    }
    
    func tianmuExpressAdDidExpourse(_ expressAd: TianmuNativeExpressAd, adView expressAdView: TianmuNativeExpressView) {
        
    }
    
    /// tableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.dataArray[indexPath.row]
        var cell : UITableViewCell!
        if item is TianmuNativeExpressView {
            cell = tableView.dequeueReusableCell(withIdentifier: adTableViewCellInentifier, for: indexPath)
            let obj = item as! UIView
            obj.tag = 999
            cell.contentView.addSubview(obj)
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellInentifier, for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center;
            cell.textLabel?.text = String.init(format: "ListViewitem %li", indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.dataArray[indexPath.row]
        if item is TianmuNativeExpressView {
            let obj = item as! UIView
            return obj.frame.size.height
        }
        return 44
    }
    
     
    
    func cleanAllAd(){
        dataArray.removeAll()
        tableView?.reloadData()
    }
}
