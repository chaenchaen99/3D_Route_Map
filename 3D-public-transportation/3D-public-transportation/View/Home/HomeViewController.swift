//
//  HomeViewController.swift
//  3d-public-transportation
//
//  Created by 정채연 on 2/21/24.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class HomeViewController: UIViewController {

    private var viewModel = HomeViewModel()
    private var homeView: UIHostingController<HomeView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        homeView = UIHostingController(rootView: HomeView(viewModel: viewModel))
        addChild(homeView)
        view.addSubview(homeView.view)
        homeView.didMove(toParent: self)

        homeView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeView.view.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

