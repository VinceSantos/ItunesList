//
//  HomeDetailHomeDetailViewController.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit

class HomeDetailViewController: UIViewController, HomeDetailViewInput {
    @IBOutlet weak var tableView: UITableView!
    
    var output: HomeDetailViewOutput!
    var listing: ItunesListModel?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        setupTableView()
    }


    // MARK: HomeDetailViewInput
    func setupInitialState() {
    }
    
    // MARK: Setup
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: String(describing: DetailImageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DetailImageTableViewCell.self))
        self.tableView.register(UINib(nibName: String(describing: DetailDescriptionTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DetailDescriptionTableViewCell.self))
    }
}

extension HomeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let detailDescriptionCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailDescriptionTableViewCell.self), for: indexPath) as! DetailDescriptionTableViewCell
            if let description = listing?.longDescription {
                detailDescriptionCell.detailDescription.text = description
            } else {
                detailDescriptionCell.detailDescription.text = "No Description Available."
            }
            detailDescriptionCell.backgroundColor = .clear
            return detailDescriptionCell
        default:
            let detailImageCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailImageTableViewCell.self), for: indexPath) as! DetailImageTableViewCell
            detailImageCell.detailImage?.image = UIImage(data: (listing?.imageData)!)
            detailImageCell.backgroundColor = .clear
            return detailImageCell
        }
    }
}
