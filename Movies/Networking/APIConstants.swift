//
//  APIConstants.swift
//  Movies
//
//  Created by Vasileios Loumanis on 30/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

struct APIConstants {
    struct Movie {
        static let moviesArrayKey = "collection"
        static let movieId = "id"
        static let headline = "headline"
        static let websiteURL = "website-url"
        static let description = "description"
        static let articleBody = "article-body"
        static let rating = "ratings"
        static let pictureURL = "picture-url"
        static let videoURL = "video-url"
        static let actors = "actors"
        static let director = "director"
        static let genre = "genre"
        static let synopsis = "synopsis"
        static let releaseDate = "release-date"
        static let duration = "duration"
        static let publishedDate = "published-date"
        static let author = "author"
        static let releaseDateFormat = "dd-MM-yyyy"
        static let publishedDateFormat = "d MMMM yyyy • hh:mma"
    }

    struct Author {
        static let name = "name"
        static let headshotURL = "headshot"
        static let twitter = "twitter"
    }

    struct UrlStrings {
        static let baseUrl = "https://s.telegraph.co.uk"
        static let moviesUrl = "/tmgmobilepub/articles.json"
    }
}
