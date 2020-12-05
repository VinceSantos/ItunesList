//
//  HomeHomeRouter.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

class HomeRouter: HomeRouterInput {
    var homeViewController: HomeViewController?
    
    func navigateToDetailView(listing: ItunesListModel) {
        let detailView = AppStoryboard.Main.instance.instantiateViewController(identifier: String(describing: HomeDetailViewController.self)) as! HomeDetailViewController
        detailView.listing = listing
        homeViewController?.present(detailView, animated: true, completion: nil)
    }
}
