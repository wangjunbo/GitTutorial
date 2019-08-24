//
//  Restaurant.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/7.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import Foundation
class Restaurant {
    var name: String
    var type: String
    var location: String
    var phone: String
    var description: String
    var image: String
    var isHidden: Bool
    var rating: String
    
    init(name: String, type: String, location: String, phone: String, description: String, image: String, isVisited: Bool,rating:String = "") {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.description = description
        self.image = image
        self.isHidden = !isVisited
        self.rating = rating
    }
    
    convenience init() {
        self.init(name: "", type: "", location: "", phone: "", description: "", image: "", isVisited: false)
    }
}
