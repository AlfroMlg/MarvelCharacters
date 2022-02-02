//
//  Date+Extensions.swift
//  MarvelComicsTechTest
//
//  Created by Alfredo Martin-Hinojal Acebal on 2/2/22.
//  Copyright © 2022 Alfredo Martin-Hinojal Acebal. All rights reserved.
//

import Foundation
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
