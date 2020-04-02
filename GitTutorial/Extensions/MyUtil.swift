//
//  MyUtil.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/9/1.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import Foundation
import AdSupport

class MyUtil
{
    static func getIDFA() -> String? {
        // check if advertising tracking is enabled in user’s setting
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return nil
        }
    }
}

