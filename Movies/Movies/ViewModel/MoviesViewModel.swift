//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Vasileios Loumanis on 30/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

protocol MoviesViewModelOutput {
    func updateTable()
    func handle(error: AppError)
    func isPerformingRequest(_: Bool)
}

class MoviesViewModel: NSObject {

    var movies: [Movie]?
    var controllerOutput: MoviesViewModelOutput?
    let networkClient = NetworkClient.shared

    let title = "Movies"

    func loadMovies() {
        controllerOutput?.isPerformingRequest(true)
        networkClient.loadMovies { [weak self] (data, error) in

            self?.controllerOutput?.isPerformingRequest(false)
            guard error == nil,
                let data = data,
                let json = data as? [String: Any] else {
                    if let error = error, let appError = error as? AppError {
                        self?.controllerOutput?.handle(error: appError)
                    }
                    self?.controllerOutput?.handle(error: NetworkClientError.jsonResponseEmpty)
                    return
            }

            let movies = Movie.array(json: json)
            self?.movies = movies
            self?.controllerOutput?.updateTable()
        }
    }

    func imageURLFor(row: Int) -> URL? {
        guard let movie = movies?[row],
            let url = movie.pictureURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let imageURL = URL(string: url) else { return nil }
        return imageURL
    }

    func titleFor(row: Int) -> String {
        guard let movie = movies?[row] else { return ""}
        return movie.headline
    }

    func ratingFor(row: Int) -> String {
        guard let movie = movies?[row], let rating = movie.rating else { return ""}
        return "\(rating)/5"
    }

    func subtitleFor(row: Int) -> String {
        guard let movie = movies?[row] else { return ""}
        var subtitle = ""
        if let duration = movie.duration {
            subtitle += duration
        }
        if let genres = movie.genre {
            subtitle += " | "
            subtitle += genres.joined(separator: ", ")
        }
        return subtitle
    }

    func yearFor(row: Int) -> String {
        guard let movie = movies?[row], let date = movie.releaseDate else { return ""}
        let year = Calendar.current.component(.year, from: date)
        return "(\(year))"
    }

    func descriptionFor(row: Int) -> String {
        guard let movie = movies?[row], let description = movie.description else { return ""}
        return description
    }

    func actorsFor(row: Int) -> String {
        guard let movie = movies?[row], let actors = movie.actors?.joined(separator: ", ") else { return ""}
        return "Actors: \(actors)"
    }

    func directorFor(row: Int) -> String {
        guard let movie = movies?[row], let director = movie.director else { return ""}
        return "Director: \(director)"
    }

    func authorFor(row: Int) -> String {
        guard let movie = movies?[row], let author = movie.author?.name else { return ""}
        return "Author: \(author)"
    }

    func synopsisFor(row: Int) -> String {
        guard let movie = movies?[row], let synopsis = movie.synopsis else { return ""}
        return synopsis
    }
}
