//
//  SnaxView.swift
//  Snax
//
//  Created by Coffey, Steven on 9/18/15.
//  Copyright © 2015 Coffey, Steven. All rights reserved.
//

import UIKit

public class SnaxView: UIView {
    
    private static let kStaticHeight: CGFloat = 50 // @@TODO <- This is arbitrary
    private static let kBevelPadding: CGFloat = 8
    
    private var message: String!
    private var type: SnaxType!
    
    /**
    Constructs a new SnaxView from options
    
    - parameter options: the flavors and notes that will pervade this snax
    */
    convenience init(mix: SnaxMix) {
        self.init(frame:SnaxView.frameForSnaxType(mix.type))
        
        self.message = mix.message
        self.type = mix.type
        self.backgroundColor = UIColor.clearColor()
    }
    
    private class func frameForSnaxType(type: SnaxType) -> CGRect {
        guard let mainView = UIApplication.sharedApplication().keyWindow else {
            return CGRectZero
        }
        
        let y = mainView.frame.size.height - kStaticHeight
        var height = kStaticHeight
        if type == SnaxType.Partial || type == SnaxType.Beveled {
            height += kBevelPadding * 2
        }
        return CGRectMake(0, y, mainView.frame.size.width, height)
    }
    
    /**
    Presents the SnaxView
    */
    public func show() {
        guard let parentView = UIApplication.sharedApplication().keyWindow else {
            return
        }
        
        self.alpha = 0
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.height / 2)
        parentView.addSubview(self)
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.alpha = 1
            self.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }
    
    typealias VoidBlock = () -> Void
    func hide(completion: VoidBlock?) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.alpha = 0
            self.transform = CGAffineTransformMakeTranslation(0, self.frame.height / 2)
            
            }) { (_) -> Void in
                self.removeFromSuperview()
                if let completionBlock = completion {
                    completionBlock()
                }
        }
    }
    
    override public func drawRect(rect: CGRect) {
        let tP = CGFloat(10)
        
        let typeFace = UIFont.systemFontOfSize(12)
        let textSize = typeFace.sizeForString(self.message)
        
        let y = (rect.height / 2) - (textSize.height / 2) - ((self.type == SnaxType.Full ? 0 : SnaxView.kBevelPadding * 3) / 2)
        let x = self.type == SnaxType.Full ? tP : tP + SnaxView.kBevelPadding
        let textRect = CGRectMake(x, y, textSize.width, textSize.height)
        
        var backgroundRect: CGRect
        
        if self.type == SnaxType.Partial || self.type == SnaxType.Beveled {
            var width = rect.size.width - (2 * SnaxView.kBevelPadding)
            if self.type == SnaxType.Partial {
                width = min(textRect.size.width + (2 * tP), width)
            }
            let innerHeight = rect.size.height - (3 * SnaxView.kBevelPadding)
            backgroundRect = CGRectMake(SnaxView.kBevelPadding, 0, width, innerHeight)
        } else {
            backgroundRect = rect
        }
        
        UIColor(white: 0, alpha: 0.7).setFill()
        var backgroundPath: UIBezierPath
        if self.type == SnaxType.Beveled || self.type == SnaxType.Partial {
            backgroundPath = UIBezierPath(roundedRect: backgroundRect, cornerRadius: 5) // @@TODO <- Arbitrary
        } else {
            backgroundPath = UIBezierPath(rect: backgroundRect)
        }
        
        // Draw the grey box inside the frame, if the type is beveled, round the corners,
        backgroundPath.fill()
        
        // Draw the message
        NSString(string: self.message).drawInRect(textRect, withAttributes:
            [NSFontAttributeName: typeFace, NSForegroundColorAttributeName : UIColor.whiteColor()])
    }
}
