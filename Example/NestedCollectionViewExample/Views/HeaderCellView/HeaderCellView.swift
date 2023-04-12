//
//  HeaderCellView.swift
//  NestedCollectionViewExample
//
//  Created by Najam us Saqib on 4/11/23.
//

import UIKit

class HeaderCellView: UICollectionViewCell {

    // MARK: - Outlets -
    @IBOutlet weak var label: UILabel!

    // MARK: - Properties -
    static let cellIdentifier = "headerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
