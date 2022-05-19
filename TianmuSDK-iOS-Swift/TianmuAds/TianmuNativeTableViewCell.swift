//
//  TianmuNativeTableViewCell.swift
//  TianmuSDK-iOS-Swift
//
//  Created by 李上京 on 2022/5/18.
//

import UIKit

class TianmuNativeTableViewCell: UITableViewCell {
    
    private var adView:UIView?
    
    func setAdView(adView: UIView?){
        self.adView?.removeFromSuperview()
        
        self.adView = adView
        
        if((adView) != nil){
            self.adView?.frame = self.contentView.bounds
            self.contentView.addSubview(self.adView!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
