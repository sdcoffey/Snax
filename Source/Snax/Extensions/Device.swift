//
//  Device.swift
//  Snax
//
//  Created by Coffey, Steven on 9/18/15.
//  Copyright © 2015 Coffey, Steven. All rights reserved.
//

import UIKit

extension UIDevice {
    class func defaultSnaxTypeForDevice() -> SnaxType {
        var type: SnaxType
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            type = SnaxType.Partial
        case .Phone:
            type = SnaxType.Full
        default:
            type = SnaxType.Full
        }
        
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight {
                type = SnaxType.Partial
        }
        
        return type
    }
}
