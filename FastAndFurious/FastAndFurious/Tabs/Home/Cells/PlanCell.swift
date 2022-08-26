//
//  PlanCell.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class PlanCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var workoutDescriptionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    @IBOutlet weak var difficultyLabel: UILabel!
    static let id = String(describing: PlanCell.self)

    @IBOutlet weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.backgroundColor = UIColor.appBackgroundColor

        self.imageView.layer.cornerRadius = 8.0
        self.mainView.layer.cornerRadius = 8.0

        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)


        difficultyLabel.clipsToBounds = true
        difficultyLabel.layer.cornerRadius = 8
        difficultyLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

}
