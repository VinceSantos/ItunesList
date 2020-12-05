//
//  UIColor.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/6/20.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
