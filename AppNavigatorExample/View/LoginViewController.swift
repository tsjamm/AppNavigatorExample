//
//  LoginViewController.swift
//  AppNavigatorExample
//
//  Created by Sai Teja on 5/26/19.
//  Copyright © 2019 Sai Teja. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHomeButton()
        addLabel()
    }
    
    private func addLabel() {
        let label = UILabel()
        label.text = "Login"
        
        view.addSubview(label)
        view.backgroundColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    private func addHomeButton() {
        let homeButton = UIBarButtonItem(title: "Home",
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: #selector(openHome))
        navigationItem.rightBarButtonItem = homeButton
    }
    
    @objc private func openHome() {
        AppNavigator(with: navigationController).navigate(to: .home)
    }
}


