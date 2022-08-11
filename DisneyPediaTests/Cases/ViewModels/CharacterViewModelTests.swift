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
        sut = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 4288)
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
        let sutWithError = CharacterViewModel(characterService: service, coordinator: coordinator, characterId: 1)
        
        // when
        let character = try! sutWithError.character.toBlocking().first()
        
        // then
        XCTAssertEqual(character?.name, "")
    }

}
