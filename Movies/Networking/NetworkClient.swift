//
//  NetworkClient.swift
//  Movies
//
//  Created by Vasileios Loumanis on 30/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Alamofire

struct NetworkClientError {
    static let jsonResponseEmpty = AppError(localizedTitle: "JSON Response Empty",
                                            localizedDescription: "JSON Response Empty", code: 0)
}

class NetworkClient {

    public static let shared = NetworkClient()

    func load(urlString: String, completion: @escaping ((Any?, Error?) -> Void)) {
        Alamofire.request(urlString).responseJSON { response in

            switch response.result {
            case .success(let data):
                completion(data, nil)

            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func loadMovies(completion: @escaping ((Any?, Error?) -> Void)) {
        load(urlString: APIConstants.UrlStrings.baseUrl + APIConstants.UrlStrings.moviesUrl) { (data, error) in
            completion(data, error)
        }
    }
}
