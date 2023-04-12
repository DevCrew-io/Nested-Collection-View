//
//  SliderCellView.swift
//  NestedCollectionViewExample
//
//  Created by Najam us Saqib on 4/7/23.
//

import UIKit

class SliderCellView: UICollectionViewCell {
    
    // MARK: - Outlets -
    @IBOutlet weak var imgSlider: UIImageView!
    
    // MARK: - Properties -
    static let cellIdentifier = "sliderCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        imgSlider.layer.cornerRadius = 8
    }

}
