//
//  HomeDetailHomeDetailPresenter.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

class HomeDetailPresenter: HomeDetailModuleInput, HomeDetailViewOutput, HomeDetailInteractorOutput {

    weak var view: HomeDetailViewInput!
    var interactor: HomeDetailInteractorInput!
    var router: HomeDetailRouterInput!

    func viewIsReady() {

    }
}
