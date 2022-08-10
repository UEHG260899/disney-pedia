//
//  CharacterCellViewModel.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 09/08/22.
//

import Foundation
import RxSwift
import RxCocoa

struct CharacterCellViewModel {
    
    private let characterListService: CharacterListServiceType
    let characterName: String
    let imageDownLoader: Observable<UIImage>
    let taskIsRunning: Driver<Bool>
    
    init(characterListService: CharacterListServiceType, name: String, imageUrl: String) {
        self.characterListService = characterListService
        self.characterName = name
        
        self.imageDownLoader = characterListService.image(url: imageUrl)
            .flatMap{ data -> Observable<UIImage> in
                let image = UIImage(data: data)

                guard let image = image else {
                    return Observable.of(UIImage(systemName: "questionmark.circle")!)
                }
                
                return Observable.of(image)
            }
        
        self.taskIsRunning = imageDownLoader.map { _ in false }
            .startWith(true)
            .asDriver(onErrorJustReturn: false)
    }
    
    
}
