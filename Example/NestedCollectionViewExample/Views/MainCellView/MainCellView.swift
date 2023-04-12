//
//  MainCellView.swift
//  NestedCollectionViewExample
//
//  Created by Najam us Saqib on 4/11/23.
//

import UIKit

class MainCellView: UICollectionViewCell {

    // MARK: - Outlets -
    @IBOutlet weak var imgPhoto: UIImageView!
    
    // MARK: - Properties -
    static let cellIdentifier = "mainCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPhoto.layer.cornerRadius = 8
    }

}
