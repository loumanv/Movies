//
//  Movie.swift
//  Movies
//
//  Created by Vasileios Loumanis on 29/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum MovieError: LocalizedError {
    case missingMovieId
    case missingHeadline
    case missingAuthorName
    static let movieInitialisationFailed = AppError(localizedTitle: "Movie Error",
                                                    localizedDescription: "Error initialising Movie", code: 0)
}

class Movie {

    var movieId: Int
    var websiteURL: String?
    var headline: String
    var description: String?
    var articleBody: String?
    var rating: Int?
    var pictureURL: String?
    var videoURL: String?
    var actors: [String]?
    var director: String?
    var genre: [String]?
    var synopsis: String?
    var releaseDate: Date?
    var duration: String?
    var publishedDate: Date?
    var author: Author?

    init(dictionary: JSONDictionary) throws {

        guard let movieId = dictionary[APIConstants.Movie.movieId] as? Int else { throw MovieError.missingMovieId}
        guard let headline = dictionary[APIConstants.Movie.headline] as? String else { throw MovieError.missingHeadline}
        self.movieId = movieId
        self.headline = headline
        self.websiteURL = dictionary[APIConstants.Movie.websiteURL] as? String
        self.description = dictionary[APIConstants.Movie.description] as? String
        self.articleBody = dictionary[APIConstants.Movie.articleBody] as? String
        self.rating = dictionary[APIConstants.Movie.rating] as? Int
        self.pictureURL = dictionary[APIConstants.Movie.pictureURL] as? String
        self.videoURL = dictionary[APIConstants.Movie.videoURL] as? String
        self.actors = dictionary[APIConstants.Movie.actors] as? [String]
        self.director = dictionary[APIConstants.Movie.director] as? String
        self.genre = dictionary[APIConstants.Movie.genre] as? [String]
        self.synopsis = dictionary[APIConstants.Movie.synopsis] as? String
        let releaseDate = dictionary[APIConstants.Movie.releaseDate] as? String
        self.releaseDate = date(dateString: releaseDate, format: APIConstants.Movie.releaseDateFormat)
        self.duration = dictionary[APIConstants.Movie.duration] as? String
        let publishedDate = dictionary[APIConstants.Movie.publishedDate] as? String
        self.publishedDate = date(dateString: publishedDate, format: APIConstants.Movie.publishedDateFormat)
        if let author = dictionary[APIConstants.Movie.author] as? JSONDictionary {
            self.author = try? Author(dictionary: author)
        }
    }

    func date(dateString: String?, format: String) -> Date? {
        guard let dateString = dateString else { return nil }
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.locale = Locale.current
        releaseDateFormatter.dateFormat = format
        return releaseDateFormatter.date(from: dateString) ?? nil
    }
}

extension Movie {
    static func array(json: JSONDictionary) -> [Movie]? {

        guard let moviesArray = json[APIConstants.Movie.moviesArrayKey] as? [JSONDictionary]  else { return nil }
        let movies: [Movie] = moviesArray.compactMap { try? Movie(dictionary: $0) }
        return movies
    }
}
