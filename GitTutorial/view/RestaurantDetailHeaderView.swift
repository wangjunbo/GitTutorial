//
//  RestaurantDetailHeaderView.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/11.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingImageView:UIImageView!
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            typeLabel.layer.cornerRadius = 5
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var heartImageView: UIImageView! {
        didSet {
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            headerImageView.tintColor = .white
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
