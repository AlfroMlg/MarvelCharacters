//
//  ViewController.swift
//  MarvelComicsTechTest
//
//  Created by Alfredo Martin-Hinojal Acebal on 2/2/22.
//  Copyright © 2022 Alfredo Martin-Hinojal Acebal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    
    
    var viewModel: MarvelComicViewModel?
    
    private var dataSource : ComicDataSource<ComicsCell,Results>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initViewModel() {
        viewModel = MarvelComicViewModel()
        self.viewModel?.bindCharacterViewModelToController = {
            self.updateDataSource()
        }
        
//        presenter?.callToData(dataType: .marvelCharacters(limit: 1,offset: 1), result: MarvelCharacter.self, completion: { (results: Result<MarvelCharacter,Error>) in
//            print(results)
//        })
    }
    
    private func updateDataSource() {
        if let resultsArray = self.viewModel?.empData.data?.results {
            self.dataSource = ComicDataSource(cellIdentifier: "ComicPreview", items: resultsArray, configureCell: { (cell, data) in
                cell.name.text = data.name
                cell.image = data.thumbnail
            })
        }
        
        
        DispatchQueue.main.async {
            self.comicsCollectionView.dataSource = self.dataSource
            self.comicsCollectionView.reloadData()
        }
    }
}

