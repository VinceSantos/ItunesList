//
//  HomeHomeViewController.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {
    var output: HomeViewOutput!
    let refreshControl = UIRefreshControl()
    var itunesCollectionList = [ItunesListModel]()
    var estimateWidth = 160.0 // Estimated Width for Universal Screen Size
    var cellMarginSize = 16.0 // Margin for the CollectionView Cells
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        collectionViewSetup()
    }

    // MARK: Setup
    // All related to the setup of the CollectionView
    func collectionViewSetup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: String(describing: ItunesListCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ItunesListCollectionViewCell.self))
        let flow = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(fetchAndRefresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    // MARK: HomeViewInput
    func setupInitialState() {
        collectionView.reloadData()
    }
    
    func showItunesList(list: [ItunesListModel], didUpdateIndex: Int) {
        if didUpdateIndex == -1 {
            DispatchQueue.main.async { [self] in
                itunesCollectionList = list
                collectionView.reloadData()
            }
        } else {
            DispatchQueue.main.async { [self] in
                itunesCollectionList = list
                let indexPath = IndexPath(item: didUpdateIndex, section: 0)
                collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    // MARK: Actions
    @objc func fetchAndRefresh() {
        output.getItunesList()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itunesCollectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itunesCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItunesListCollectionViewCell.self), for: indexPath) as! ItunesListCollectionViewCell
        if itunesCollectionList[indexPath.row].imageData == nil {
            let defaultImage = UIImage.gradientImageWithBounds(bounds: CGRect(x: 0, y: 0, width: 200, height: 200), colors: [UIColor.random().cgColor, UIColor.random().cgColor])

            itunesCell.listImage.image = defaultImage
        } else {
            itunesCell.listImage.image = UIImage(data: itunesCollectionList[indexPath.row].imageData!)
        }
        itunesCell.listGenre.text = itunesCollectionList[indexPath.row].primaryGenreName
        itunesCell.listTitle.text = itunesCollectionList[indexPath.row].trackName
        itunesCell.listPrice.text = "\(itunesCollectionList[indexPath.row].trackPrice?.description ?? "") USD"
        itunesCell.listImage.layer.cornerRadius = 5
        return itunesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.showDetailView(listing: itunesCollectionList[indexPath.row])
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width + 65)
    }
    
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}
