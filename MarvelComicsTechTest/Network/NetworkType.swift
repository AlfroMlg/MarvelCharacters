//
//  NetworkType.swift
//  MarvelComicsTechTest
//
//  Created by Alfredo Martin-Hinojal Acebal on 2/2/22.
//  Copyright © 2022 Alfredo Martin-Hinojal Acebal. All rights reserved.
//

import Foundation
protocol EndPointType {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task : HTTPTask { get }
}
