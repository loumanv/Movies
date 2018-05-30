//
//  Factory.swift
//  MoviesTests
//
//  Created by Vasileios Loumanis on 29/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation
import XCTest

class Factory {

    static func createMovie() -> Movie {

        let dictionary: JSONDictionary = [
            "id": 1,
            "website-url": "http://www.telegraph.co.uk/film/the-revenant/",
            "headline": "The revenant",
            "description": "Leo's beautiful endurance test",
            "article-body": "This is the article body",
            "ratings": 4,
            "picture-url": "http://www.telegraph.co.uk/content/dam/film/the revenant/leo-xlarge.jpg",
            "video-url": "http://www.telegraph.co.uk/content/dam/film/the revenant/video.avi",
            "actors": [
                "Leonardo DiCaprio",
                "Tom Hardy",
                "Domhnall Gleeson",
                "Will Poulter"
            ],
            "director": "Alejandro G. Iñárritu",
            "genre": [
                "Action",
                "Drama"
            ],
            "synopsis": "In the 1820s, a frontiersman, Hugh Glass, sets out on a path of vengeance...",
            "release-date": "15-01-2015",
            "duration": "156 mins",
            "published-date": "14 January 2016 • 12:00pm",
            "author": [
                "name": "Robbie Collin",
                "headshot": "http://www.telegraph.co.uk/content/dam/film/team/robbie-USE-small.jpg",
                "twitter": "@robbiereviews"
            ]
        ]
        return try! Movie(dictionary: dictionary)
    }

    static func createMovies() -> [Movie] {
        let fileURL = Bundle(for: Movie.self).url(forResource: "movies", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JSONDictionary
        return Movie.array(json: dictionary)!
    }

    static func createAuthor() -> Author {

        let dictionary: JSONDictionary = [
            "name": "Robbie Collin",
            "headshot": "http://www.telegraph.co.uk/content/dam/film/team/robbie-USE-small.jpg",
            "twitter": "@robbiereviews"
        ]
        return try! Author(dictionary: dictionary)
    }
}
