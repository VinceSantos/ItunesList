//
//  HomeDetailHomeDetailConfigurator.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit

class HomeDetailModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HomeDetailViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: HomeDetailViewController) {

        let router = HomeDetailRouter()

        let presenter = HomeDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = HomeDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
