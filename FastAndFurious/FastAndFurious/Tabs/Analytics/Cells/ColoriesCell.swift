//
//  ColoriesCell.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class ColoriesCell: UICollectionViewCell {

    static let id = String(describing: ColoriesCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 1.0
    }

}
