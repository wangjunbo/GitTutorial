//
//  RestaurantDetailTextCell.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/12.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 0 
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
