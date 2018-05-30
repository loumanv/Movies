//
//  MovieTests.swift
//  MovieTests
//
//  Created by Vasileios Loumanis on 29/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Movies

class MovieTests: XCTestCase {

    func testMovieInitializationSucceeds() {
        let movie = Factory.createMovie()
        XCTAssertNotNil(movie)
    }

    func testMovieJsonParseSucceeds() {
        let movie = Factory.createMovie()
        XCTAssertEqual(movie.movieId, 1)
        XCTAssertEqual(movie.websiteURL, "http://www.telegraph.co.uk/film/the-revenant/")
        XCTAssertEqual(movie.headline, "The revenant")
        XCTAssertEqual(movie.description, "Leo's beautiful endurance test")
        XCTAssertEqual(movie.articleBody, "This is the article body")
        XCTAssertEqual(movie.rating, 4)
        XCTAssertEqual(movie.pictureURL, "http://www.telegraph.co.uk/content/dam/film/the revenant/leo-xlarge.jpg")
        XCTAssertEqual(movie.videoURL, "http://www.telegraph.co.uk/content/dam/film/the revenant/video.avi")
        XCTAssertEqual(movie.actors?.first, "Leonardo DiCaprio")
        XCTAssertEqual(movie.actors?.last, "Will Poulter")
        XCTAssertEqual(movie.director, "Alejandro G. Iñárritu")
        XCTAssertEqual(movie.genre?.first, "Action")
        XCTAssertEqual(movie.genre?.last, "Drama")
        XCTAssertEqual(movie.synopsis, "In the 1820s, a frontiersman, Hugh Glass, sets out on a path of vengeance...")
        XCTAssertEqual(movie.releaseDate?.description, "2015-01-15 00:00:00 +0000")
        XCTAssertEqual(movie.duration, "156 mins")
        XCTAssertEqual(movie.publishedDate?.description, "2016-01-14 12:00:00 +0000")
        XCTAssertNotNil(movie.author)
    }

    func testMoviesInitializationSucceeds() {
        let movies = Factory.createMovies()
        XCTAssertNotNil(movies)
    }

    func testMoviesJsonParseSucceeds() {
        let movies = Factory.createMovies()
        XCTAssertEqual(movies.count, 10)
    }
}
