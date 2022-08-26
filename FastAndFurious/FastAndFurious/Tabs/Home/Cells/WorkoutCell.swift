//
//  WorkoutCell.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class WorkoutCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var caloryView: UIView!

    @IBOutlet weak var timeView: UIView!

    @IBOutlet weak var caloryLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var overlayView: UIView!

    static let id = String(describing: WorkoutCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.appBackgroundColor

        self.mainView.layer.cornerRadius = 24.0
        self.backgroundImage.layer.cornerRadius = 24.0
        self.overlayView.layer.cornerRadius = 24.0

        self.caloryView.layer.cornerRadius = 8.0
        self.timeView.layer.cornerRadius = 8.0

        backgroundImage.clipsToBounds = true
        overlayView.clipsToBounds = true

        addGradient()

    }

    private func addGradient() {
        let colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            UIColor(red: 0, green: 0, blue: 0.3, alpha: 0)
        ]

        overlayView.addGradientToView(colors: colors, rect: overlayView.bounds, isVertical: false)
    }

}
