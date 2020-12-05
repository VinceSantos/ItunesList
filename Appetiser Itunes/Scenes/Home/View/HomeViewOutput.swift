//
//  HomeHomeViewOutput.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

protocol HomeViewOutput {

    /**
        @author Vince Santos
        Notify presenter that view is ready
    */

    func viewIsReady()
    func showDetailView(listing: ItunesListModel)
    func getItunesList()
}
