//
//  MoviesViewModelTests.swift
//  MoviesTests
//
//  Created by Vasileios Loumanis on 31/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Movies

class MockMoviesViewModel: MoviesViewModel {
    override func loadMovies() {
        movies = Factory.createMovies()
    }
}

class MoviesViewModelTests: XCTestCase {

    func testMoviesViewModelInitializationSucceeds() {
        let viewModel = MockMoviesViewModel()
        viewModel.loadMovies()
        XCTAssertNotNil(viewModel)
    }

    func testMoviesViewModelReturnsTheCorrectInfo() {
        let viewModel = MockMoviesViewModel()
        viewModel.loadMovies()

        let expectedURL = URL(string: "http://www.telegraph.co.uk/content/dam/film/the%20revenant/leo-xlarge.jpg")
        XCTAssertEqual(viewModel.imageURLFor(row: 0), expectedURL)
        XCTAssertEqual(viewModel.titleFor(row: 0), "The revenant")
        XCTAssertEqual(viewModel.subtitleFor(row: 0), "156 mins | Action, Drama")
        XCTAssertEqual(viewModel.yearFor(row: 0), "(2015)")
        XCTAssertEqual(viewModel.descriptionFor(row: 0), "Leo's beautiful endurance test")
        let expectedActors = "Actors: Leonardo DiCaprio, Tom Hardy, Domhnall Gleeson, Will Poulter"
        XCTAssertEqual(viewModel.actorsFor(row: 0), expectedActors)
        XCTAssertEqual(viewModel.directorFor(row: 0), "Director: Alejandro G. Iñárritu")
        XCTAssertEqual(viewModel.authorFor(row: 0), "Author: Robbie Collin")
        let expectedSynopsis = "In the 1820s, a frontiersman, Hugh Glass, sets out on a path of vengeance..."
        XCTAssertEqual(viewModel.synopsisFor(row: 0), expectedSynopsis)
    }
}
