//
//  HorizontalCollectionView.swift
//  HorizontalCalendarView
//
//  Created by Rahul on 24/08/22.
//

import UIKit

struct Event {
    var isSelected: Bool
    var date: Date
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.date == rhs.date
    }
}

protocol HorizontalCalendarViewDelegate: AnyObject {
    func didSelect(event: Event)
}

class HorizontalCalendarView: UIView {

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: 50, height: 45)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    var horizontalCalendarVM: HorizontalCalendarVM!

    weak var delegate: HorizontalCalendarViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(horizontalCalendarVM: HorizontalCalendarVM) {
        self.init(frame: .zero)
        self.horizontalCalendarVM = horizontalCalendarVM
        self.setupUI()
        self.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - UI Related
extension HorizontalCalendarView {

    private func setupUI() {
        self.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HorizontalCalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return horizontalCalendarVM.events.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.id,
                                                            for: indexPath) as? CalendarCell else {
            return .init()
        }

        cell.setup(event: horizontalCalendarVM.events[indexPath.item])

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalCalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEvent = horizontalCalendarVM.events[indexPath.item]

        if horizontalCalendarVM.selectedEvent == selectedEvent { return }

        let isUpdated = horizontalCalendarVM.updateEvents(for: indexPath.item)

        if isUpdated {
            delegate?.didSelect(event: selectedEvent)
            collectionView.reloadData()
        }
    }
}
