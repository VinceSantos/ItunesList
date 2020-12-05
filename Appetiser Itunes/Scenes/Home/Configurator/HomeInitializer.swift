//
//  HomeHomeInitializer.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit

class HomeModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var homeViewController: HomeViewController!

    override func awakeFromNib() {

        let configurator = HomeModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: homeViewController)
    }

}
