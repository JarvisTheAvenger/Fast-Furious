//
//  HeartRateCell.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class HeartRateCell: UICollectionViewCell {

    static let id = String(describing: HeartRateCell.self)

    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var graphView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
