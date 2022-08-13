//
//  CharacterViewModel.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/08/22.
//

import XCTest
import RxTest
import RxBlocking
@testable import DisneyPedia

class CharacterViewModelTests: XCTestCase {

    var sut: CharacterViewModel!
    var service: CharacterServiceType!
    var coordinator: SceneCoordinatorType!
    
    override func setUp() {
        super.setUp()
        service = CharacterService()
        coordinator = SceneCoordinatorMock()
        sut = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4288, imageUrl: "")
    }
    
    override func tearDown() {
        service = nil
        sut = nil
        coordinator = nil
        super.tearDown()
    }
    
    
    func testIfCharacterViewModelCanBeInstantiated() {
        // then
        XCTAssertNotNil(sut)
    }
    
    func testIfCharacterServiceIsAssignedOnInit() {
        // then
        XCTAssertNotNil(sut.service)
    }
    
    func testIfCoordinatorIsAssignedOnInit() {        
        // then
        XCTAssertNotNil(sut.coordinator)
    }
    
    func testIfCharacterIdIsAssignedOnInit() {
        XCTAssertNotNil(sut.characterId)
    }
    
    func testIfCharacterObservableEmmitsACharacter() {
        // then
        XCTAssertNotNil(try sut.character.toBlocking().first())
    }
    
    func testIfCharacterObservableEmitsCorrectData() {
        // given
        let subject = try! sut.character.toBlocking().first()
        
        XCTAssertEqual(subject?.name, "Marty and Maple")
    }
    
    func testIfCharacterObservableEmitsMockDataOnError() {
        // given
        let sutWithError = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 1, imageUrl: "")
        
        // when
        let character = try! sutWithError.character.toBlocking().first()
        
        // then
        XCTAssertEqual(character?.name, "")
    }
        
    func testIfShouldHideFilmsEmmitsFalseWhenCharacterHasFilms() {
        // given
        let sutWithFilms = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 938, imageUrl: "")
        
        // when
        let value = try! sutWithFilms.shouldHideFilms.toBlocking().first()
        
        // then
        XCTAssertFalse(value!)
    }
    
    func testIfShouldShowFilmsDoesntEmmitsWhenCharacterDoesntHaveFilms() {
        // given
        let sutWithFilms = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 542, imageUrl: "")
        
        // when
        let value = try! sutWithFilms.shouldHideFilms.toBlocking().first()
        
        // then
        XCTAssertNil(value)
    }
    
    func testIfShouldHideShortFilmsEmmitsFalseWhenCharacterHasShortFilms() {
        // given
        let sutWithShortFilms = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4324, imageUrl: "")
        
        // when
        let value = try! sutWithShortFilms.shouldHideShortFilms.toBlocking().first()
        
        // then
        XCTAssertFalse(value!)
    }
    
    func testIfShouldHideShortFilmsDoesntEmmitWhenCharacterDoesntHaveShortFilms() {
        // given
        let sutWithoutShortFilms = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4323, imageUrl: "")
        
        // when
        let value = try! sutWithoutShortFilms.shouldHideShortFilms.toBlocking().first()
        
        // then
        XCTAssertNil(value)
    }
    
    func testIfShouldHideTvShowsEmmitsFalseWhenCharacterHasTvShows() {
        // given
        let sutWithTvShows = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4327, imageUrl: "")
        
        // when
        let value = try! sutWithTvShows.shouldHideTvShows.toBlocking().first()
        
        // then
        XCTAssertFalse(value!)
    }
    
    func testIfShouldHideTvShowsDoesntEmmitsWhenCharacterDoesntHasTvShows() {
        // given
        let sutWithoutTvShows = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4329, imageUrl: "")
        
        // when
        let value = try! sutWithoutTvShows.shouldHideTvShows.toBlocking().first()
        
        // then
        XCTAssertNil(value)
    }
    
    func testIfShouldDisplayVideoGamesEmmitsFalseWhenCharacterHasVideoGames() {
        // given
        let sutWithVideoGames = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4324, imageUrl: "")
        
        // when
        let value = try! sutWithVideoGames.shouldHideVideoGames.toBlocking().first()
        
        // then
        XCTAssertFalse(value!)
    }
    
    func testIfShouldDisplayVideoGamesDoesntEmmitsWhenCharacterDoesntHaveVideoGames() {
        // given
        let sutWithoutVideoGames = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4325, imageUrl: "")
        
        // when
        let value = try! sutWithoutVideoGames.shouldHideVideoGames.toBlocking().first()
        
        // then
        XCTAssertNil(value)
    }
    
    func testIfShouldHideAttractionsEmmitsFalseWhenCharacterHasAttractions() {
        // given
        let sutWithAttractions = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4310, imageUrl: "")
        
        // when
        let value = try! sutWithAttractions.shouldHideAttractions.toBlocking().first()
        
        // then
        XCTAssertFalse(value!)
    }

    
    func testIfShouldHideAttractionsDoesntEmmitWhenCharacterDoesntHaveAttractions() {
        // given
        let sutWithoutAttractions = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4288, imageUrl: "")
        
        // when
        let value = try! sutWithoutAttractions.shouldHideAttractions.toBlocking().first()
        
        // then
        XCTAssertNil(value)
    }

    
    func testIfImageDownloadingEmmitsTrueByDefault() {
        // given
        let value = try! sut.imageIsDownloading.toBlocking().first()
        
        // then
        XCTAssertTrue(value!)
    }
    
}
