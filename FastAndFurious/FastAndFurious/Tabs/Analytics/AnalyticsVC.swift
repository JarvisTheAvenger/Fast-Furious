//
//  AnalyticsViewController.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class AnalyticsVC: UIViewController {

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "July 2022"
        label.font = AppFont.bold.size(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var calendarView: HorizontalCalendarView = {
        let view = HorizontalCalendarView(horizontalCalendarVM: viewModel)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Item -> Group -> Section -> Layout
    private lazy var layout: UICollectionViewLayout = {

        // Layout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            // Section
            var section: NSCollectionLayoutSection?

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(30)
            )

            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )

            switch sectionIndex {

            case 0:
                section = self.getCaloriesSection()
            case 1:
                section = self.getStepSection()
            default:
                section = self.getSleepSection()
            }

            if sectionIndex == 0 {
                section!.boundarySupplementaryItems = [ header ]
            }

            return section
        }

        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)

        return collectionView

    }()

    let viewModel = HorizontalCalendarVM()

    override func loadView() {
        super.loadView()

        setupUI()
    }

}

// MARK: - UI Related
private extension AnalyticsVC {
    func setupUI() {
        registerCells()
        addViews()
        addConstraints()
    }

    func registerCells() {
        collectionView.register(LabelCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: LabelCollectionReusableView.id)

        collectionView.register(UINib(nibName: HeartRateCell.id, bundle: nil),
                                forCellWithReuseIdentifier: HeartRateCell.id)

        collectionView.register(UINib(nibName: ColoriesCell.id, bundle: nil),
                                forCellWithReuseIdentifier: ColoriesCell.id)

        collectionView.register(UINib(nibName: TrainingTimeCell.id, bundle: nil),
                                forCellWithReuseIdentifier: TrainingTimeCell.id)

        collectionView.register(UINib(nibName: SleepCell.id, bundle: nil),
                                forCellWithReuseIdentifier: SleepCell.id)

        collectionView.register(UINib(nibName: WaterCell.id, bundle: nil),
                                forCellWithReuseIdentifier: WaterCell.id)

        collectionView.register(UINib(nibName: CyclingCell.id, bundle: nil),
                                forCellWithReuseIdentifier: CyclingCell.id)

        collectionView.register(UINib(nibName: StepsCell.id, bundle: nil),
                                forCellWithReuseIdentifier: StepsCell.id)

        collectionView.register(UINib(nibName: KeepItUpCell.id, bundle: nil),
                                forCellWithReuseIdentifier: KeepItUpCell.id)
    }

    func addViews() {
        self.view.addSubview(dateLabel)
        self.view.addSubview(calendarView)
        self.view.addSubview(collectionView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 24),
            dateLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -20),
            dateLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                           constant: 20),
        ])

        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: 12),
            calendarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -20),
            calendarView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor,
                                              constant: 12),
            calendarView.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -20),
            collectionView.topAnchor.constraint(equalTo: self.calendarView.bottomAnchor,
                                                constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -16)
        ])
    }

    func getCaloriesSection() -> NSCollectionLayoutSection {

        // Calories Item
        let coloriesItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.32))
        let coloriesItem = NSCollectionLayoutItem(layoutSize: coloriesItemSize)
        coloriesItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Training Item
        let trainingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.68))
        let trainingItem = NSCollectionLayoutItem(layoutSize: trainingItemSize)
        trainingItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Cycling Item
        let cyclingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1.0))
        let cyclingItem = NSCollectionLayoutItem(layoutSize: cyclingItemSize)
        cyclingItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Calories + Training Group
        let coloriesTrainingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let coloriesTrainingGroup = NSCollectionLayoutGroup.vertical(layoutSize: coloriesTrainingGroupSize, subitems: [coloriesItem, trainingItem])

        // Outer group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.37))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [ coloriesTrainingGroup, cyclingItem])

        let section = NSCollectionLayoutSection(group: outerGroup)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    func getStepSection() -> NSCollectionLayoutSection {
        // Step Item
        let stepsItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.65))
        let stepsItem = NSCollectionLayoutItem(layoutSize: stepsItemSize)
        stepsItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Banner Item
        let bannerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
        let bannerItem = NSCollectionLayoutItem(layoutSize: bannerItemSize)
        bannerItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Cycling Item
        let heartItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.55), heightDimension: .fractionalHeight(1.0))
        let heartItem = NSCollectionLayoutItem(layoutSize: heartItemSize)
        heartItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Step + Banner Group
        let stepBannerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(1))
        let stepBannerGroup = NSCollectionLayoutGroup.vertical(layoutSize: stepBannerGroupSize, subitems: [stepsItem, bannerItem])

        // Outer group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.28))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [heartItem, stepBannerGroup])

        let section = NSCollectionLayoutSection(group: outerGroup)
        section.orthogonalScrollingBehavior = .groupPaging

        return section

    }

    private func getSleepSection() -> NSCollectionLayoutSection {
        // Sleep Item
        let sleepItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1))
        let sleepItem = NSCollectionLayoutItem(layoutSize: sleepItemSize)
        sleepItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Water Item
        let waterItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let waterItem = NSCollectionLayoutItem(layoutSize: waterItemSize)
        waterItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.28))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [sleepItem, waterItem])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }


}

// MARK: - Cells Helper
private extension AnalyticsVC {
    func getHeartCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeartRateCell.id,
                                                            for: indexPath) as? HeartRateCell else {
            return .init()
        }
        return cell
    }

    func getCaloriesCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColoriesCell.id,
                                                            for: indexPath) as? ColoriesCell else {
            return .init()
        }

        return cell
    }

    func getTrainingTimeCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingTimeCell.id,
                                                            for: indexPath) as? TrainingTimeCell else {
            return .init()
        }

        return cell
    }

    func getSleepCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SleepCell.id,
                                                            for: indexPath) as? SleepCell else {
            return .init()
        }

        return cell
    }

    func getWaterCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterCell.id,
                                                            for: indexPath) as? WaterCell else {
            return .init()
        }

        return cell
    }


    func getCyclingCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CyclingCell.id,
                                                            for: indexPath) as? CyclingCell else {
            return .init()
        }

        return cell
    }

    func getStepsCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StepsCell.id,
                                                            for: indexPath) as? StepsCell else {
            return .init()
        }

        return cell
    }

    func getKeepItUpCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeepItUpCell.id,
                                                            for: indexPath) as? KeepItUpCell else {
            return .init()
        }

        return cell
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AnalyticsVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        if section == 0 || section == 1 {
            return 3
        }

        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {

            if indexPath.item == 0 {
                return getCaloriesCell(for: indexPath)
            } else if indexPath.item == 1 {
                return getTrainingTimeCell(for: indexPath)
            }

            return getCyclingCell(for: indexPath)

        } else if indexPath.section == 1 {

            if indexPath.item == 0 {
                return getHeartCell(for: indexPath)
            } else if indexPath.item == 1 {
                return getStepsCell(for: indexPath)
            }

            return getKeepItUpCell(for: indexPath)
        }

        if indexPath.item == 0 {
            return getSleepCell(for: indexPath)
        }

        return getWaterCell(for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let id = LabelCollectionReusableView.id

            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: id,
                                                                                   for: indexPath) as?  LabelCollectionReusableView else {
                return .init()
            }

            headerView.backgroundColor = .white

            headerView.headerLabel.text = "Today Report"

            return headerView

        default:
            preconditionFailure("Unexpected element kind")
        }

    }
}
