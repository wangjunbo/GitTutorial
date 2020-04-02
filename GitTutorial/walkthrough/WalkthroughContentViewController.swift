//
//  WalkthroughContentViewController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/9/1.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet var headingLabel:UILabel!
//        {
//        didSet {
//            headingLabel.numberOfLines = 0
//        }
//    }
   
    @IBOutlet var subHeadingLabel:UILabel!
//        {
//        didSet {
//            headingLabel.numberOfLines = 0
//        }
//    }
    
    @IBOutlet var contentImageView:UIImageView!
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
    }

}
