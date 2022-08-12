//
//  CharacterViewModel.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 10/08/22.
//

import Foundation
import RxSwift
import RxCocoa

struct CharacterViewModel {
    
    let service: CharacterServiceType
    let coordinator: SceneCoordinatorType
    let characterId: Int64
    let character: Driver<DisneyCharacter>
    let taskIsRunning: Driver<Bool>
    let films: Driver<[String]>
    let shouldHideFilms: Driver<Bool>
    
    init(characterService: CharacterServiceType, coordinator: SceneCoordinatorType, characterId: Int64) {
        self.service = characterService
        self.coordinator = coordinator
        self.characterId = characterId
        
        self.character = service.character(id: characterId)
            .asDriver(onErrorJustReturn: .mock)
        
        
        self.taskIsRunning = self.character
            .map { _ in false }
            .startWith(true)
            .asDriver(onErrorJustReturn: false)
        
        self.films = self.character
            .map(\.films)
            .filter { !$0.isEmpty }
        
        self.shouldHideFilms = self.films
            .map { _ in false }
    }
    
}
