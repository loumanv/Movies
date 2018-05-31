//
//  MoviesViewController.swift
//  Movies
//
//  Created by Vasileios Loumanis on 30/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit
import AlamofireImage

protocol MoviesViewControllerOutput {
    func didSelectRowAction(sender: UIViewController, selectedMovie: Movie)
}

class MoviesViewController: UIViewController {

    var viewModel: MoviesViewModel
    var controllerOutput: MoviesViewControllerOutput?

    let numberOfCellsPerRowPhonePotrait: CGFloat = 1
    let numberOfCellsPerRowPadOrLandscape: CGFloat = 2

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let name = String(describing: MovieCell.self)
            collectionView.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
        }
    }

    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MoviesViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        viewModel.controllerOutput = self
        collectionView.delegate = self
        collectionView.dataSource = self
        addNavigationItems()
        reload()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        reload()
    }

    @objc func reload() {
        viewModel.loadMovies()
    }

    private func cellWidth() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation.isLandscape {
            if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                return (view.frame.width - flowLayout.minimumInteritemSpacing) / numberOfCellsPerRowPadOrLandscape
            }
        }
        return view.frame.width / numberOfCellsPerRowPhonePotrait
    }

    private func addNavigationItems() {
        let activityBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem  = activityBarButton
        activityIndicator.startAnimating()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reload",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(reload))
    }

    private func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension MoviesViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self),
                                                      for: indexPath)
        guard let movieCell = cell as? MovieCell else { return MovieCell() }
        if let imageUrl = viewModel.imageURLFor(row: indexPath.row) {
            movieCell.imageView.af_setImage(withURL: imageUrl, imageTransition: .crossDissolve(0.30))
        }
        movieCell.titleLabel.text = viewModel.titleFor(row: indexPath.row)
        movieCell.subtitleLabel.text = viewModel.subtitleFor(row: indexPath.row)
        movieCell.yearLabel.text = viewModel.yearFor(row: indexPath.row)
        movieCell.descriptionLabel.text = viewModel.descriptionFor(row: indexPath.row)
        movieCell.actorsLabel.text = viewModel.actorsFor(row: indexPath.row)
        movieCell.directorLabel.text = viewModel.directorFor(row: indexPath.row)
        movieCell.authorLabel.text = viewModel.authorFor(row: indexPath.row)
        movieCell.synopsisLabel.text = viewModel.synopsisFor(row: indexPath.row)
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = viewModel.movies else { return }
        controllerOutput?.didSelectRowAction(sender: self, selectedMovie: movies[indexPath.row])
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: cellWidth(), height: cellWidth())
    }
}

extension MoviesViewController: MoviesViewModelOutput {
    func updateTable() {
        collectionView.reloadData()
    }

    func handle(error: AppError) {
        showErrorMessage(title: error.localizedTitle, message: error.localizedDescription)
    }

    func isPerformingRequest(_ isPerformingRequest: Bool) {
        isPerformingRequest ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
