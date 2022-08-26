//
//  CyclingCell.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class CyclingCell: UICollectionViewCell {

    static let id = String(describing: CyclingCell.self)

    @IBOutlet weak var mapView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.mapView.layer.cornerRadius = 12.0
        self.mapView.layer.borderColor = UIColor.clear.cgColor
        self.mapView.layer.borderWidth = 1.0
    }

}
