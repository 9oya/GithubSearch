//
//  HomeViewController.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/04.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension HomeViewController {
    private func setupLayout() {
        view.backgroundColor = .systemGray6
    }
}
