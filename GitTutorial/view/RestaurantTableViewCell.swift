//
//  RestaurantTableViewCell.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/2.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    var imageName:String!
//    = "" {
//        didSet {
//            thumbnailImageView.image = UIImage(named: imageName)
//        }
//    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel! {
        didSet {
            locationLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
