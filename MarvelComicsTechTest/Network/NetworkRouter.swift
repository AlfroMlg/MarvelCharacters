//
//  NetworkRouter.swift
//  MarvelComicsTechTest
//
//  Created by Alfredo Martin-Hinojal Acebal on 2/2/22.
//  Copyright © 2022 Alfredo Martin-Hinojal Acebal. All rights reserved.
//

import Foundation
struct NetworkRouter {
    static let environement : NetworkEnvironment = .production
    private let networkManager = NetworkManager<DataType>()
    
    fileprivate var session : URLSession {
        get {
            let config = URLSessionConfiguration.ephemeral
            config.timeoutIntervalForRequest = 10
            config.timeoutIntervalForResource = 10
            let session = URLSession.init(configuration: config)
            return session
        }
    }
    var objectTask : URLSessionDataTask!
    
    func callToData<K: Codable>(dataType : DataType, result: K.Type, completion: @escaping (Result<K, Error>) -> Void) {
        networkManager.request(route: dataType) { (results:Result<K, Error>) in
            completion(results)
        }
    }
}
