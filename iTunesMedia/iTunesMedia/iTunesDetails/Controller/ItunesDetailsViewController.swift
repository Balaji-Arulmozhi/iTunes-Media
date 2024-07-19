//
//  ItunesDetailsViewController.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import UIKit

class ItunesDetailsViewController: UIViewController {
    
    @IBOutlet weak var ListLayoutView: UIView!
    @IBOutlet weak var GridLayoutView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var groupedItems: [String: [resultsDataModel]]?
    
    
    private lazy var tableViewController: ListViewViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ListViewViewController") as! ListViewViewController
        self.add(asChildViewController: viewController, to: ListLayoutView)
        return viewController
    }()
    
    
    private lazy var collectionViewController: GridViewLayoutViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "GridViewLayoutViewController") as! GridViewLayoutViewController
        self.add(asChildViewController: viewController, to: GridLayoutView)
        return viewController
    }()
    
    
    
    private func updateView() {
        ListLayoutView.isHidden = segmentedControl.selectedSegmentIndex != 1
        GridLayoutView.isHidden = segmentedControl.selectedSegmentIndex != 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        
        setupSegmentedControl()
        updateView()
        
        tableViewController.groupedItems = groupedItems
        collectionViewController.groupedItems = groupedItems
        
    }
    
    
    
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
    }
    
    @objc private func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController, to containerView: UIView) {
        addChild(viewController)
        
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
