//
//  TabbarViewController.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

class TabbarViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var tabbarButtons: [UIButton]!
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var container: UIView!

    private var viewControllers: [UIViewController] = []
    private var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.layer.cornerRadius = 30.0
        setViewControllers()
        setup()
    }

    @IBAction func tabBarButtonTapped(_ sender: Any) {
        let sender = sender as! UIButton
        changeTab(sender.tag)
    }
}

// MARK: - Tabbar Related
private extension TabbarViewController {

    func setup() {
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = self.container.bounds
        self.container.addSubview(vc.view)
        vc.didMove(toParent: nil)
    }

    func setViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let exploreVC = storyboard.instantiateViewController(withIdentifier: "ExploreVC") as! ExploreVC
        let analyticsVC = storyboard.instantiateViewController(withIdentifier: "AnalyticsVC") as! AnalyticsVC
        let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC

        viewControllers = [homeVC, exploreVC, analyticsVC , accountVC]
    }

    func changeTab(_ index : Int) {
        let previousIndex = selectedIndex
        selectedIndex = index
        // Remove previous tab from container view
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()

        // Add new tab to container view
        let vc = viewControllers[index]
        addChild(vc)
        vc.view.frame = container.bounds
        self.container.addSubview(vc.view)
        vc.didMove(toParent: self)

        // Show previous button as deselected
        let previousButton = tabbarButtons[previousIndex]
        previousButton.isSelected = false

        // Update selected button with appearance
        let selectedButton = tabbarButtons[index]

        selectedButton.isSelected = true
    }
    
}
