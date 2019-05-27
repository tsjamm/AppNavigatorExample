//
//  HomeViewController.swift
//  AppNavigatorExample
//
//  Created by Sai Teja on 5/26/19.
//  Copyright © 2019 Sai Teja. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var appNavigator = AppNavigator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appNavigator.navigationController = navigationController
        
        addProfileButton()
        addNewsButton()
        addLabel()
    }
    
    private func addLabel() {
        let label = UILabel()
        label.text = "Home"
        
        view.addSubview(label)
        view.backgroundColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    private func addProfileButton() {
        let profileButton = UIBarButtonItem(title: "Profile",
                                          style: UIBarButtonItem.Style.plain,
                                          target: self,
                                          action: #selector(openProfile))
        navigationItem.rightBarButtonItem = profileButton
    }
    
    private func addNewsButton() {
        let newsButton = UIBarButtonItem(title: "News",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(openNews))
        navigationItem.leftBarButtonItem = newsButton
    }
    
    @objc private func openProfile() {
        appNavigator.navigate(to: .profile)
    }
    
    @objc private func openNews() {
        if let newsViewController = appNavigator.navigate(to: .news) as? NewsViewController {
            newsViewController.newsLabelText = "News - Opened from Home"
        }
    }
    
}

