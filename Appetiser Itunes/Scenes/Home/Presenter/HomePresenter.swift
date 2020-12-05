//
//  HomeHomePresenter.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

class HomePresenter: HomeModuleInput, HomeViewOutput, HomeInteractorOutput {
    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!

    func viewIsReady() {
        interactor.getItunesList()
    }
    
    // MARK: From View Controller
    func getItunesList() {
        interactor.getItunesList()
    }
    
    // MARK: To Router
    func showDetailView(listing: ItunesListModel) {
        router.navigateToDetailView(listing: listing)
    }

    // MARK: From Interactor
    func setItunesList(list: [ItunesListModel], didUpdateIndex: Int) {
        view.showItunesList(list: list, didUpdateIndex: didUpdateIndex)
        view.endRefreshing()
    }
}
