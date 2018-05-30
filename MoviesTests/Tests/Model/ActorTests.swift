//
//  AuthorTests.swift
//  MovieTests
//
//  Created by Vasileios Loumanis on 29/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Movies

class AuthorTests: XCTestCase {

    func testAuthorInitializationSucceeds() {
        let author = Factory.createAuthor()
        XCTAssertNotNil(author)
    }

    func testAuthorJsonParseSucceeds() {
        let author = Factory.createAuthor()
        XCTAssertEqual(author.name, "Robbie Collin")
        XCTAssertEqual(author.headshotURL, "http://www.telegraph.co.uk/content/dam/film/team/robbie-USE-small.jpg")
        XCTAssertEqual(author.twitter, "@robbiereviews")
    }
}
