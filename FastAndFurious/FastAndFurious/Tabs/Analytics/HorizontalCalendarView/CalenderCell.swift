//
//  CalenderCell.swift
//  HorizontalCollectionView
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    static let id = String(describing: CalendarCell.self)

    let dayNameFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "EE"
        return dateFormatter
    }()

    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 12.0
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.semiBold.size(14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup Data
extension CalendarCell {
    func setup(event: Event) {
        let name = Calendar.current.isDateInToday(event.date) ? "Today" : dayNameFormatter.string(from: event.date)

        let day = String(event.date.get(.day))
        textLabel.text = "\(name)\n\(day)"

        if event.isSelected {
            textLabel.textColor = .white
            mainView.layer.borderColor = UIColor.clear.cgColor
            mainView.backgroundColor = UIColor.primaryDark
        } else {
            textLabel.textColor = .black
            mainView.layer.borderColor = UIColor.black.cgColor
            mainView.backgroundColor = UIColor.primaryYellow
        }
    }
}

// MARK: - UI Related
extension CalendarCell {
    private func setupUI() {
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4)
        ])

        mainView.addSubview(textLabel)

        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4)
        ])
    }
}
