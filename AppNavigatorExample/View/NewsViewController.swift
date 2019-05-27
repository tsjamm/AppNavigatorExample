//
//  NewsViewController.swift
//  AppNavigatorExample
//
//  Created by Sai Teja on 5/26/19.
//  Copyright © 2019 Sai Teja. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsLabelText: String = "News"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLabel()
        addCloseButton()
    }
    
    private func addLabel() {
        let newsLabel = UILabel()
        newsLabel.text = newsLabelText
        
        view.addSubview(newsLabel)
        view.backgroundColor = .white
        
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    private func addCloseButton() {
        let closeButton = UIBarButtonItem(title: "Close",
                                          style: UIBarButtonItem.Style.plain,
                                          target: self,
                                          action: #selector(closeViewController))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc private func closeViewController() {
        dismiss(animated: true, completion: nil)
    }
}
