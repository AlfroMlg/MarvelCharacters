//
//  Endpoints.swift
//  MarvelComicsTechTest
//
//  Created by Alfredo Martin-Hinojal Acebal on 2/2/22.
//  Copyright © 2022 Alfredo Martin-Hinojal Acebal. All rights reserved.
//

import Foundation
enum NetworkEnvironment {
    case dev
    case production
}

public enum DataType {
    case marvelCharacters(limit: Int, offset: Int)
    case marvelCharactersDetail(limit: Int, offset: Int, characterId: Int)
}

struct MarvelApi {
    static let privateKey: String = "b854f9f274b27db311dfad6d32282093adae6254"
    static let publicKey: String = "f9de853259b0ab9b40e2577aac370dac"
    static let kBaseUrl: String = "https://gateway.marvel.com"
    static let characters: String = "/v1/public/characters?"
    static let charactersDetail: String = "/v1/public/characters/"
    static let hash: String = {
        let currentTimeStamp = Date().toMillis()
        let hash = (String(currentTimeStamp!) + privateKey + publicKey).md5()
        return hash
    }()
    static let currentTimeStamp = Date().toMillis()
}
extension DataType : EndPointType {
    
    var task: HTTPTask {
        switch self {
        case .marvelCharacters:
            return .request
        case .marvelCharactersDetail:
            return .request
        }
    }
    
    var baseUrl: String {
        return MarvelApi.kBaseUrl
    }
    
    var path: String {
        switch self {
        case .marvelCharacters(let limit, let offset):
            return MarvelApi.characters + "ts=\(MarvelApi.currentTimeStamp!)&apikey=\(MarvelApi.publicKey)&hash=\(MarvelApi.hash)&limit=\(limit)&offset=\(offset)"
        case .marvelCharactersDetail(let limit, let offset, let characterId):
            return MarvelApi.charactersDetail + "\(characterId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .GET
    }
}
