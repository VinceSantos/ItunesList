//
//  HomeDetailHomeDetailInitializer.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit

class HomeDetailModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var homedetailViewController: HomeDetailViewController!

    override func awakeFromNib() {

        let configurator = HomeDetailModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: homedetailViewController)
    }

}
