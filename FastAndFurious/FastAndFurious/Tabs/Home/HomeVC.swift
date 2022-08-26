//
//  ViewController.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

enum HomeSections: Int, CaseIterable {
    case popularWorkouts, todayPlan
}

class HomeVC: UIViewController {

    // Item -> Group -> Section -> Layout
    private lazy var layout: UICollectionViewLayout = {

        // Layout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var columns = 1

            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            // Group
            var groupHeight = NSCollectionLayoutDimension.absolute(44)

            var groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)

            // Section
            var section = NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]))

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
                groupHeight = NSCollectionLayoutDimension.absolute(190)
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: groupHeight)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging

            default:
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: columns)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
            }

            section.boundarySupplementaryItems = [ header ]

            return section
        }

        return layout
    }()

    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good Morning 🔥"
        label.font = AppFont.semiBold.size(14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rahul Umap"
        label.font = AppFont.extraBold.size(24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage()

        searchBar.searchTextField.font = AppFont.regular.size(14.0)
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var collectionView: UICollectionView = {

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.appBackgroundColor
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)

        return collectionView

    }()

    // MARK: - ViewController's lifecycle
    override func loadView() {
        super.loadView()

        setupUI()
    }
    
}

// MARK: - Private methods
private extension HomeVC {
    func setupUI() {
        self.view.backgroundColor = UIColor.appBackgroundColor
        registerCells()
        addViews()
        addContraints()
    }

    func addViews() {
        self.view.addSubview(greetingLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
    }

    func addContraints() {

        NSLayoutConstraint.activate([
            greetingLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            greetingLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.greetingLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.greetingLabel.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.greetingLabel.bottomAnchor, constant: 4)
        ])

        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 20)
        ])


        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchTextField.heightAnchor.constraint(equalToConstant: 40),
                searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
                searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
                searchTextField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor)
            ])
            searchTextField.clipsToBounds = true
            searchTextField.font = AppFont.regular.size(14.0)
            searchTextField.layer.cornerRadius = 4.0
        }

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16)
        ])

    }

    func registerCells() {
        collectionView.register(LabelCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: LabelCollectionReusableView.id)

        collectionView.register(UINib(nibName: WorkoutCell.id, bundle: nil),
                                forCellWithReuseIdentifier: WorkoutCell.id)

        collectionView.register(UINib(nibName: PlanCell.id, bundle: nil),
                                forCellWithReuseIdentifier: PlanCell.id)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSections.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return indexPath.section == 0 ? getWorkoutCell(for: indexPath) : getPlanCell(for: indexPath)
    }

    private func getWorkoutCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutCell.id,
                                                            for: indexPath) as? WorkoutCell else {
            return .init()
        }
        return cell
    }

    private func getPlanCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanCell.id,
                                                            for: indexPath) as? PlanCell else {
            return .init()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let id = LabelCollectionReusableView.id

            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as?  LabelCollectionReusableView else {
                return .init()
            }

            let title = indexPath.section == 0 ? "Popular Workouts" : "Today Plan"
            headerView.headerLabel.text = title

            return headerView

        default:
            preconditionFailure("Unexpected element kind")
        }

    }
}
