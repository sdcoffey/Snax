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

public class Snax: NSObject {
    
    private static var snaxQueue: [SnaxView] = []
    
    /**
    Shows a basic snax with the provided message
    
    - parameter message: The message for the snax
    */
    public class func show(message: String) {
        let newSnax = SnaxView(message: message, type: defaultSnaxTypeForDevice())
        queueSnax(newSnax)
    }
    
    private class func queueSnax(snax: SnaxView) {
        if snaxQueue.count == 0 {
            showSnaxInternal(snax)
        }
        snaxQueue.append(snax)
    }
    
    private class func showSnaxInternal(snax: SnaxView) {
        snax.show()
        let _ = NSTimer.scheduledTimerWithTimeInterval(2.5, target: Snax.self, selector: "onTimerFire:", userInfo: snax, repeats: false)
    }
    
    class func onTimerFire(timer: NSTimer) {
        let currentSnax = timer.userInfo as? SnaxView
        if let snax = currentSnax {
            snax.hide {
                snaxQueue.removeFirst()
                if snaxQueue.count > 0 {
                    showSnaxInternal(snaxQueue[0])
                }
            }
        }
        timer.invalidate()
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
