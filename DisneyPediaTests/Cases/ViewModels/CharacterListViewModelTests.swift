//
//  CharacterListViewModelTests.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 06/08/22.
//

import XCTest
import RxTest
import RxBlocking
@testable import DisneyPedia

class CharacterListViewModelTests: XCTestCase {

    var date: Date!
    var calendar: Calendar!
    var currentHour: Int!
    var service: CharacterListServiceType!
    var coordinator: SceneCoordinatorType!
    var sut: CharacterListViewModel!
    
    override func setUp() {
        super.setUp()
        date = Date()
        calendar = Calendar.current
        currentHour = calendar.component(.hour, from: date)
        service = CharacterListService()
        coordinator = SceneCoordinatorMock()
        sut = CharacterListViewModel(characterListService: service, sceneCoordinator: coordinator)
    }
    
    override func tearDown() {
        date = nil
        calendar = nil
        currentHour = nil
        service = nil
        sut = nil
        coordinator = nil
        super.tearDown()
    }
    
    
    func testIfCharacterListViewModelCanBeInstantiated() {
        XCTAssertNotNil(sut)
    }
    
    func testIfAttributesAreAsignedWhenInitialized() {
        XCTAssertNotNil(sut.characterListService)
        XCTAssertNotNil(sut.sceneCoordinator)
    }

    func testIfInitialGreetingChangesDependingOnTimeOfDay() {
        
        if currentHour < 12 {
            XCTAssertEqual(try sut.firstGreeting.toBlocking().first(), "¡Buenos días!")
        } else {
            XCTAssertEqual(try sut.firstGreeting.toBlocking().first(), "¡Buenas tardes!")
        }
        
    }
    
    func testIfContinousGreetingChangesDependingOnTimeOfDay() {
        
        // then
        if currentHour < 12 {
            XCTAssertEqual(try sut.continousGreeting.toBlocking().first(), "¡Buenos días!")
        } else {
            XCTAssertEqual(try sut.continousGreeting.toBlocking().first(), "¡Buenas tardes!")
        }
        
    }
    
    func testIfGreetingOutputChangesDependingOnTimeOfDay() {
        
        if currentHour < 12 {
            XCTAssertEqual(try sut.greeting.toBlocking().first(), "¡Buenos días!")
        } else {
            XCTAssertEqual(try sut.greeting.toBlocking().first(), "¡Buenas tardes!")
        }

    }

}
