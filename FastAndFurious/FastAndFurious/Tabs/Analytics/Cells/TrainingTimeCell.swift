//
//  TrainingTimeCell.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class TrainingTimeCell: UICollectionViewCell {

    static let id = String(describing: TrainingTimeCell.self)

    @IBOutlet weak var trainingTimeLabel: UILabel!
    @IBOutlet weak var circularProgressView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        let progressView = CircularProgressView(frame: CGRect(x: -10, y: -40, width: 55, height: 55), lineWidth: 8, rounded: false)

        progressView.progressColor = UIColor.init(hex: "A48AED")

        progressView.trackColor = .white

        progressView.center = circularProgressView.center

        circularProgressView.addSubview(progressView)

        progressView.progress = 0.8

        self.layoutIfNeeded()

        trainingTimeLabel.text = "Training Time\n 80%"
    }

}
