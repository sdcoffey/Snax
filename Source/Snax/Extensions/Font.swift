//
//  Font.swift
//  Snax
//
//  Created by Coffey, Steven on 9/18/15.
//  Copyright © 2015 Coffey, Steven. All rights reserved.
//

import UIKit

extension UIFont {
    
    func sizeForString(string: String) -> CGSize {
        return NSString(string: string).boundingRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self], context: nil).size
    }
}
