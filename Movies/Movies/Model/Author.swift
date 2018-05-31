//
//  Author.swift
//  Movies
//
//  Created by Vasileios Loumanis on 29/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

class Author {

    internal var name: String
    internal var headshotURL: String?
    internal var twitter: String?

    init(dictionary: JSONDictionary) throws {
        guard let name = dictionary[APIConstants.Author.name] as? String else { throw MovieError.missingAuthorName}
        self.name = name
        self.headshotURL = dictionary[APIConstants.Author.headshotURL] as? String
        self.twitter = dictionary[APIConstants.Author.twitter] as? String
    }
}
