//
//  HomeHomeConfigurator.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit

class HomeModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HomeViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: HomeViewController) {

        let router = HomeRouter()
        router.homeViewController = viewController
        let presenter = HomePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = HomeInteractor()
        InternetConnectionService.shared.delegate = interactor
        interactor.itunesListService.delegate = interactor
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
