//
//  AppStoryboards.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/20.
//

import UIKit

enum AppStoryboard: String {
    case Main
    
    var instance: UIStoryboard
    {
       return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
