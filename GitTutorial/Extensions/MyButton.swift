//
//  addAttributes.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/9/1.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 { // @IBInspectable 可以在Attributes 界面上显示
        didSet {
            layer.cornerRadius = cornerRadius // 圆角的设置
            layer.masksToBounds = cornerRadius > 0  // 负值为否
        }
    }
}
