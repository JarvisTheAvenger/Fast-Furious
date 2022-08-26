//
//  StepsCell.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class StepsCell: UICollectionViewCell {
    static let id = String(describing: StepsCell.self)

    @IBOutlet weak var progressView: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderColor = UIColor.init(hex: "FFE8C6").cgColor
        self.contentView.layer.borderWidth = 1.0

        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)


    }

}
