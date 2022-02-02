//
//  MarvelComicViewModel.swift
//  MarvelComicsTechTest
//
//  Created by Alfredo Martin-Hinojal Acebal on 2/2/22.
//  Copyright © 2022 Alfredo Martin-Hinojal Acebal. All rights reserved.
//

import Foundation
class MarvelComicViewModel: NSObject {
    private var networkRouter: NetworkRouter?
    private(set) var empData : MarvelCharacter! {
        didSet {
            self.bindCharacterViewModelToController()
        }
    }
    var bindCharacterViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        networkRouter = NetworkRouter()
        requestData()
    }
    
    func requestData() {
        self.networkRouter?.callToData(dataType: .marvelCharacters(limit: 1, offset: 1), result: MarvelCharacter.self, completion: { (result: Result<MarvelCharacter, Error>) in
            print(result)
        })
    }
}
