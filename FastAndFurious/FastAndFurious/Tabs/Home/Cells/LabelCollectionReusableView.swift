//
//  LabelReusableView.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class LabelCollectionReusableView: UICollectionReusableView {

    // MARK: - Outlets

    lazy var headerLabel: UILabel! = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.bold.size(18.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var mainStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(headerLabel)
        return stackView
    }()

    static let id = String(describing: LabelCollectionReusableView.self)

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {

        self.backgroundColor = UIColor.appBackgroundColor

        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])

    }

}
