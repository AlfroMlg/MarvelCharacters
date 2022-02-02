//
//  NetworkManager.swift
//  MarvelComicsTechTest
//
//  Created by Alfredo Martin-Hinojal Acebal on 2/2/22.
//  Copyright © 2022 Alfredo Martin-Hinojal Acebal. All rights reserved.
//

import Foundation
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask : URLSessionDataTaskProtocol{
}

extension URLSession : URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request as URLRequest, completionHandler: completionHandler as URLSessionProtocol.DataTaskResult) as URLSessionDataTask)
    }
}

protocol Networkable : class {
    associatedtype EndPoint: EndPointType
    func request<K: Codable>(route: EndPoint, completion: @escaping (Result<K, Error>) -> Void)
    
}

class NetworkManager<EndPoint: EndPointType>: Networkable {
    
    lazy var session : URLSessionProtocol = URLSession.shared
    
    /**
     Network request to get array
     */
    func request<K: Codable>(route: EndPoint, completion: @escaping (Result<K, Error>) -> Void) {
        
        let request = self.buildRequest(from: route)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let jsonData = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(K.self, from: jsonData)
                    let result : Result<K,Error> = Result.success(response)
                    completion(result)
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "Empty data", code: 404, userInfo: nil)
                completion(.failure(error))
            }
        })
        task.resume()
    }
    
    
    fileprivate func buildRequest(from route: EndPointType) -> URLRequest {
        
        var request = URLRequest.init(url: URL.init(string: route.baseUrl + route.path)!)
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
