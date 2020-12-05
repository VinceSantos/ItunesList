//
//  ItunesListCollectionViewCell.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/20.
//

import UIKit

class ItunesListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var listImage: UIImageView! 
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listGenre: UILabel!
    @IBOutlet weak var listPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
