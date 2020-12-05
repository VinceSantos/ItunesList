//
//  HomeHomeViewInput.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

protocol HomeViewInput: class {

    /**
        @author Vince Santos
        Setup initial state of the view
    */

    func setupInitialState()
    func showItunesList(list: [ItunesListModel], didUpdateIndex: Int)
    func endRefreshing()
}
