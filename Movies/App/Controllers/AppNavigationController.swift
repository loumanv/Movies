//
//  AppNavigationController.swift
//  Movies
//
//  Created by Vasileios Loumanis on 28/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit
import SafariServices

class AppNavigationController {
    static let sharedInstance = AppNavigationController()

    lazy var navigationController: UINavigationController = {
        let moviesVC = MoviesViewController(viewModel: MoviesViewModel())
        moviesVC.controllerOutput = self
        let navigationController = UINavigationController(rootViewController: moviesVC)
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = .white
        return navigationController
    }()
}

extension AppNavigationController: MoviesViewControllerOutput {

    func didSelectRowAction(sender: UIViewController, selectedMovie: Movie) {
        guard let urlString = selectedMovie.websiteURL, let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.title = selectedMovie.headline
        safariVC.configuration.barCollapsingEnabled = true
        safariVC.configuration.entersReaderIfAvailable = true
        navigationController.pushViewController(safariVC, animated: true)
    }
}
