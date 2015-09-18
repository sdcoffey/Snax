//
//  Snax.swift
//  Snax
//
//  Created by Coffey, Steven on 9/18/15.
//  Copyright © 2015 Coffey, Steven. All rights reserved.
//

import UIKit

enum SnaxType {
    case Full
    case Beveled
    case Partial
}

public class Snax {
    
    public class func show(message: String) {
        let snax = SnaxView.SnaxViewWithType(SnaxType.Beveled, message: message)
        snax.show()
    }
    
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
        
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight {
                type = SnaxType.Partial
        }
        
        return type
    }
}
