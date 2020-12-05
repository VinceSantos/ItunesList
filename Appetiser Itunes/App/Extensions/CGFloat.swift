//
//  CGFloat.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/6/20.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
