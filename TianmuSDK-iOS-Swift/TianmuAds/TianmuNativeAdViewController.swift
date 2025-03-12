//
//  TianmuNativeAdViewController.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 陈则富 on 2021/11/2.
//

import UIKit


class TianmuNativeAdViewController: BaseViewController, TianmuNativeExpressAdDelegate, UITableViewDelegate, UITableViewDataSource {
    func tianmuExpressAdDidPresent(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        
    }
    

    private var adViewArray: Array<UIView & TianmuExpressViewRegisterProtocol> = Array<UIView & TianmuExpressViewRegisterProtocol>.init()
    private var isNormalAd = true
    private var isReady = false
    
    private var nativeAd: TianmuNativeExpressAd?
    private var tableView: UITableView?
    private var items:Array = Array<Any>.init()
    
    private var posId = "6173f490ab52"
    private var bidPosId = "fbc75e4826d3"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setAdConfigBtn = UIButton.init(type: UIButton.ButtonType.custom)
        setAdConfigBtn.setTitle("切换", for: UIControl.State.normal)
        setAdConfigBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        setAdConfigBtn.frame = CGRect.init(x: 0, y: 0, width: 50, height: 20)
        setAdConfigBtn.addTarget(self, action: #selector(showTypeSelect), for: UIControl.Event.touchUpInside)
        
        let rightItem = UIBarButtonItem.init(customView: setAdConfigBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.setUI()
        // Do any additional setup after loading the view.
        
        nativeAd = TianmuNativeExpressAd.init(adSize: CGSize.init(width: SCREEN_WIDTH, height: 10))
        
        nativeAd?.delegate = self;
        self.posId = "6173f490ab52";
        self.bidPosId = "fbc75e4826d3";
        nativeAd?.controller = self;
        
        adViewArray = Array<UIView & TianmuExpressViewRegisterProtocol>.init()
        
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
    
    @objc func loadNomarlAd(){
        isNormalAd = true
        isReady = false
        nativeAd?.posId = self.posId
        nativeAd?.load(withCount: 3)
    }
    
    @objc func loadBidAd(){
        isNormalAd = false
        isReady = false
        nativeAd?.posId = self.bidPosId
        nativeAd?.load(withCount: 3)
    }
    
    @objc func bidWin(){
        if (isNormalAd){
            self.view.makeToast("当前广告不是竞价广告")
            return;
        }
        if isReady && (nativeAd != nil){
            for adView in adViewArray {
                nativeAd?.sendWinNotification(withAdView: adView, price: adView.bidFloor)
                adView.tianmu_registViews([adView])
            }
            adViewArray.removeAll()
            return;
        }
        self.view.makeToast("广告未准备好")
    }
    
    @objc func bidFail(){
        if (isNormalAd){
            self.view.makeToast("当前广告不是竞价广告")
            return;
        }
        if isReady && (nativeAd != nil){
            for adView in adViewArray {
                nativeAd?.sendWinFailNotificationReason(TianmuAdBiddingLossReason.other, winnerPirce: 100, adView: adView)
                adView.tianmu_registViews([adView])
            }
            adViewArray.removeAll()
            return;
        }
        self.view.makeToast("广告未准备好")
    }

    func setUI(){
        items = Array<Any>.init();
        
        tableView = UITableView.init()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(object_getClass(UITableViewCell()), forCellReuseIdentifier: "cell")
        tableView?.register(object_getClass(TianmuNativeTableViewCell()), forCellReuseIdentifier:  "adcell")
        self.view.addSubview(tableView!)
        tableView?.frame = self.view.bounds
        
        tableView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.cleanAllAd()
        })
        
        tableView?.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.nativeAd?.load(withCount: 3)
        })
    }
    
    @objc func showTypeSelect (){
        let alertVc = UIAlertController.init(title: "", message: "选择信息流类型", preferredStyle: UIAlertController.Style.actionSheet)
        let expressType = UIAlertAction.init(title: "模板", style: UIAlertAction.Style.default) { action in
            self.cleanAllAd()
            self.posId = "6173f490ab52"
            self.bidPosId = "fbc75e4826d3";
        }
        let nativeType = UIAlertAction.init(title: "自渲染", style: UIAlertAction.Style.default) { action in
            self.cleanAllAd()
            self.posId = "5738b2e19a04";
            self.bidPosId = "3dc0eba57261";
        }
        let cancel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel)
        alertVc.addAction(expressType)
        alertVc.addAction(nativeType)
        alertVc.addAction(cancel)
        self.present(alertVc, animated: true, completion: nil)
    }
    
    func cleanAllAd(){
        adViewArray.removeAll()
        items.removeAll()
        items = Array<Any>.init()
        tableView?.reloadData()
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.items[indexPath.row]
        if item is TianmuNativeExpressView {
            let obj = item as! UIView
            return obj.frame.size.height
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        
        if item is TianmuNativeExpressView {
            var cell : TianmuNativeTableViewCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "adcell", for: indexPath) as? TianmuNativeTableViewCell
            cell.setAdView(adView: item as? UIView)
            return cell
        } else {
            var cell : UITableViewCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center;
            cell.textLabel?.text = String.init(format: "ListViewitem %li", indexPath.row)
            return cell
        }
    }
    
    // MARK: TianmuNativeExpressAdDelegate
    
    // 模板信息流广告加载成功
    func tianmuExpressAdSucceed(toLoad expressAd: TianmuNativeExpressAd, views: [UIView & TianmuExpressViewRegisterProtocol]) {
        isReady = true
        for adView in views {
            if(adView.renderType == .native){
                self.setUpUnifiedTopImageNativeAdView(adView:adView)
            }
            if(isNormalAd){
                adView.tianmu_registViews([adView])
            }else{
                adViewArray.append(adView)
                self.view.makeToast("该信息流广告价格:\(adView.bidPrice)")
            }
        }
        self.tableView?.mj_header?.endRefreshing()
        self.tableView?.mj_footer?.endRefreshing()
    }
    
    // 模板信息流广告加载失败
    func tianmuExpressAdFail(toLoad expressAd: TianmuNativeExpressAd, error: Error) {
        tableView?.mj_header?.endRefreshing()
        tableView?.mj_footer?.endRefreshing()
    }
    
    //渲染成功
    func tianmuExpressAdRenderSucceed(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        DispatchQueue.main.async { [self] in
            for _ in 0...6 {
                self.items.append(NSNull.init())
            }
            self.items.append(expressAdView)
            tableView?.reloadData()
        }
    }
    
    // 模板信息流广告渲染失败
    func tianmuExpressAdRenderFail(_ expressAd: TianmuNativeExpressView, error: Error) {
        self.view.makeToast("信息流渲染失败：\(error)")
    }
    
    func tianmuExpressAdClosed(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        let index = items.firstIndex { view in
            if(view is TianmuNativeExpressView){
                return (view as! TianmuNativeExpressView) == expressAdView
            }else{
                return false
            }
        }
        if(index != nil){
            self.items.remove(at: index!)
        }
        
        tableView?.reloadData()
    }
    
    func tianmuExpressAdClick(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        
    }
    
    func tianmuExpressAdDidExpourse(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        
    }
    
    // MARK: 以下为视频信息流相关回调

    // 模板信息流视频广告开始播放
    func tianmuExpressAdVideoPlay(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        print("视频信息流播放");
    }

    // 模板信息流视频广告视频播放失败
    func tianmuExpressAdVideoPlayFail(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol, error: Error) {
        print("视频信息流播放失败，\(error)")
    }

    
    // 模板信息流视频广告视频暂停
    func tianmuExpressAdVideoPause(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        print("视频信息流播放暂停")
    }
    
    func tianmuExpressAdVideoFinish(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        print("视频信息流播放完成")
    }

    func tianmuExpressAdDidCloseLandingPage(_ expressAd: TianmuNativeExpressAd, adView expressAdView: UIView & TianmuExpressViewRegisterProtocol) {
        
    }

    func setUpUnifiedTopImageNativeAdView(adView : UIView & TianmuExpressViewRegisterProtocol){
        // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
        let adWidth = self.view.frame.size.width;
        let adHeight = (adWidth - 17 * 2) / 16.0 * 9 + 70;
        adView.frame = CGRect.init(x:0, y:0, width:adWidth, height:adHeight);

        // 显示logo图片（必要）
        let logoImage = UIImageView.init()
        adView.addSubview(logoImage)
        adView.tianmu_platformLogoImageDarkMode(false,loadImageBlock:{ image in
            if(image != nil){
                let maxWidth = 40.0;
                let logoHeight = maxWidth / image!.size.width * image!.size.height;
                logoImage.frame = CGRect.init(x:adWidth - maxWidth, y:adHeight - logoHeight, width:maxWidth, height:logoHeight);
                logoImage.image = image;
            }
        });

        // 设置主图/视频（主图可选，但强烈建议带上,如果有视频试图，则必须带上）
        let mainFrame = CGRect.init(x:17, y:0, width:adWidth - 17 * 2, height:(adWidth - 17 * 2) / 16.0 * 9);
        if(adView.adData?.isVideoAd == true) {
            let mediaView = adView.tianmu_mediaView(forWidth: mainFrame.size.width);
            if(mediaView != nil){
                mediaView!.frame = mainFrame;
                adView.addSubview(mediaView!)
            }
        } else {
            let imageView = UIImageView.init()
            imageView.backgroundColor = UIColor.adsy_color(withHexString: "#cccccc")
            adView.addSubview(imageView)
            imageView.frame = mainFrame;
            var urlStr:String = adView.adData?.imageUrl ?? "";
            if urlStr.isEmpty {
                urlStr = adView.adData?.imageUrlArray.first ?? ""
            }
            if(urlStr.count > 0) {
                DispatchQueue.global().async {
                    let url = URL.init(string: urlStr)
                    if(url != nil){
                        do{
                            let data = try Data.init(contentsOf: url!)
                            let image = UIImage.init(data:data)
                            DispatchQueue.main.async {[imageView] in
                                imageView.image = image
                            }
                        }catch{}
                    }
                }
            }
        }

        // 设置广告标识（可选）
        let adLabel = UILabel.init()
        adLabel.backgroundColor = UIColor.adsy_color(withHexString: "#cccccc")
        adLabel.textColor = UIColor.adsy_color(withHexString: "#FFFFFF")
        adLabel.font = UIFont.adsy_PingFangLightFont(12)
        adLabel.text = adView.adData?.channel
        adView.addSubview(adLabel)
        adLabel.frame = CGRect(x:17, y:(adWidth - 17 * 2) / 16.0 * 9 + 9, width:36, height:18)
        adLabel.textAlignment = .center

        // 设置广告描述(可选)
        let descLabel = UILabel.init();
        descLabel.textColor = UIColor.adsy_color(withHexString: "#333333")
        descLabel.font = UIFont.adsy_PingFangLightFont(12)
        descLabel.textAlignment = .left
        descLabel.text = adView.adData?.desc;
        adView.addSubview(descLabel)
        descLabel.frame = CGRect.init(x:17 + 36 + 4, y:(adWidth - 17 * 2) / 16.0 * 9 + 9, width:self.view.frame.size.width - 57 - 17 - 20, height:18);

        // 设置标题文字（可选，但强烈建议带上）
        let titlabel = UILabel.init()
        adView.addSubview(titlabel)
        titlabel.font = UIFont.adsy_PingFangMediumFont(14)
        titlabel.textColor = UIColor.adsy_color(withHexString: "#333333");
        titlabel.numberOfLines = 2
        titlabel.text = adView.adData?.title
        let textSize = titlabel.sizeThatFits(CGSize.init(width:adWidth - 17 * 2, height:999));
        titlabel.frame = CGRect.init(x:17, y:(adWidth - 17 * 2) / 16.0 * 9 + 30, width:adWidth - 17 * 2, height:textSize.height);

        // 展示关闭按钮（必要）
        let closeButton = UIButton.init();
        adView.addSubview(closeButton)
        adView.bringSubviewToFront(closeButton)
        closeButton.frame = CGRect.init(x:adWidth - 44, y:0, width:44, height:44);
        closeButton.setImage(UIImage.init(named: "close"), for: UIControl.State.normal)
        // tianmu_close方法为协议中方法 直接添加target即可 无需实现
        closeButton.addTarget(adView, action: #selector(adView.tianmu_close), for: UIControl.Event.touchUpInside)
    }
    
}
