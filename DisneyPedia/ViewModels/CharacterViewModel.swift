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
    let shortFilms: Driver<[String]>
    let videoGames: Driver<[String]>
    let tvShows: Driver<[String]>
    let attractions: Driver<[String]>
    let shouldHideFilms: Driver<Bool>
    let shouldHideShortFilms: Driver<Bool>
    let shouldHideTvShows: Driver<Bool>
    let shouldHideVideoGames: Driver<Bool>
    let shouldHideAttractions: Driver<Bool>
    
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
        
        self.shortFilms = self.character
            .map(\.shortFilms)
            .filter { !$0.isEmpty }
        
        self.shouldHideShortFilms = self.shortFilms
            .map { _ in false }
        
        self.tvShows = self.character
            .map(\.tvShows)
            .filter { !$0.isEmpty }
        
        self.shouldHideTvShows = self.tvShows
            .map { _ in false }
        
        self.videoGames = self.character
            .map(\.videoGames)
            .filter { !$0.isEmpty }
        
        self.shouldHideVideoGames = self.videoGames
            .map { _ in false }
        
        self.attractions = self.character
            .map(\.parkAttractions)
            .filter { !$0.isEmpty }
        
        self.shouldHideAttractions = self.attractions
            .map { _ in false }
    }
    
}
