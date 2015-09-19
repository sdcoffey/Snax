//
//  Snax.swift
//  Snax
//
//  Created by Coffey, Steven on 9/18/15.
//  Copyright © 2015 Coffey, Steven. All rights reserved.
//

import UIKit

public enum SnaxType {
    case Full
    case Beveled
    case Partial
}

public class SnaxMix {
    var message: String = ""
    var type: SnaxType = UIDevice.defaultSnaxTypeForDevice()
    var duration: NSTimeInterval = kSnaxDurationDefault
    
    public init(message: String) {
        self.message = message
    }
    
    public func setType(type: SnaxType) -> SnaxMix {
        self.type = type
        return self
    }
    
    public func setDuration(duration: NSTimeInterval) -> SnaxMix {
        self.duration = duration
        return self
    }
}

let kSnaxDurationDefault = NSTimeInterval(2.5)
public class Snax: NSObject {
    
    private static var snaxQueue: [SnaxMix] = []
    
    /**
    Shows a basic snax with the provided message
    
    - parameter message: The message for the snax
    */
    public class func show(message: String) {
        let options = SnaxMix(message: message)
        queueSnax(options)
    }
    
    /**
    More advanced implemenations that allows for greater customization
    
    - parameter mix: A SnaxMix that describes this Snax
    */
    public class func show(mix: SnaxMix) {
        queueSnax(mix)
    }
    
    private class func queueSnax(snax: SnaxMix) {
        if snaxQueue.count == 0 {
            showSnaxInternal(snax)
        }
        snaxQueue.append(snax)
    }
    
    private class func showSnaxInternal(mix: SnaxMix) {
        let snax = SnaxView(mix: mix)
        snax.show()
        
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(mix.duration * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) { () -> Void in
            snax.hide {
                let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
                dispatch_after(dispatchTime, dispatch_get_main_queue(), { () -> Void in
                    snaxQueue.removeFirst()
                    if snaxQueue.count > 0 {
                        showSnaxInternal(snaxQueue[0])
                    }
                })
            }
        }
    }
}
