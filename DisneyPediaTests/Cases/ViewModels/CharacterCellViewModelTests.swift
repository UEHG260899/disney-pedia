//
//  CharacterCellViewModelTests.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 09/08/22.
//

import XCTest
import RxTest
import RxBlocking
@testable import DisneyPedia

class CharacterCellViewModelTests: XCTestCase {

    var service: CharacterListServiceType!
    var sut: CharacterCellViewModel!
    
    override func setUp() {
        super.setUp()
        service = CharacterListService()
        sut = CharacterCellViewModel(characterListService: service, name: "Test", imageUrl: "https://static.wikia.nocookie.net/disney/images/7/74/Marty_and_Maple.png")
    }
    
    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }
    
    
    func testIfCharacterCellViewModelCanBeInstantiated() {
        XCTAssertNotNil(sut)
    }
    
    func testIfImageDataObservableEmitsData() {
        // then
        XCTAssertNotNil(try sut.imageDownLoader.toBlocking().first)
    }

}
