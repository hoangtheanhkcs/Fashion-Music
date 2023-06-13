//
//  MainTabBarController.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func minizeTrackDetail()
    func maximizeTrackDetail(viewModel: TrackModel?)
}

class MainTabBarController: UITabBarController {
    
     
    
    private var minimizedTopAnchorConstraints: NSLayoutConstraint!
    private var maximizedTopAnchorConstraints: NSLayoutConstraint!
    private var bottomAnchorConstrains: NSLayoutConstraint!
    
    
    
   private let searchVC :MusicViewController01 = MusicViewController01.loadFromStoryBoard()
    private let discoverVC:DiscoverViewController = DiscoverViewController.loadFromStoryBoard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.tabBarDelegate = self
        discoverVC.mainTabBar = self
        discoverVC.trackDetail = trackDetailView
        searchVC.trackDetailMM = trackDetailView
        
        viewControllers = [
                           generateVC(title: "Library", image: "library", rootViewController: discoverVC),
                           generateVC(title: "Search", image: "search", rootViewController: searchVC)
        ]
        setupTrackDetailView()
    }
    
    
  
    
    
    
    private func generateVC(title:String, image:String, rootViewController:UIViewController) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(named: image)
        navigationVC.tabBarItem.title = title
//        navigationVC.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationVC
    }
    private func setupTrackDetailView() {
        trackDetailView.tabBarDelegate = self
        
        
        trackDetailView.delegate = searchVC
      
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        // MARK:- AutoLayout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        maximizedTopAnchorConstraints = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
       minimizedTopAnchorConstraints = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstrains = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstrains.isActive = true
        maximizedTopAnchorConstraints.isActive = true
        
//      trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
extension MainTabBarController: MainTabBarControllerDelegate {
    
    func maximizeTrackDetail(viewModel: TrackModel?) {
        
        minimizedTopAnchorConstraints.isActive = false
        maximizedTopAnchorConstraints.isActive = true
        maximizedTopAnchorConstraints.constant = 0
        bottomAnchorConstrains.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 0
                        self.trackDetailView.miniTackView.alpha = 0
                        self.trackDetailView.maximizedStackView.alpha = 1
                       },
                       completion: nil)
        
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
    }

    func minizeTrackDetail() {
        
        maximizedTopAnchorConstraints.isActive = false
        bottomAnchorConstrains.constant = view.frame.height
        minimizedTopAnchorConstraints.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 1
                        self.trackDetailView.miniTackView.alpha = 1
                        self.trackDetailView.maximizedStackView.alpha = 0
                       },
                       completion: nil)
    }
}
