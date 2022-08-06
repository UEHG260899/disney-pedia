//
//  CharacterListViewModelTests.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 06/08/22.
//

import XCTest
@testable import DisneyPedia

class CharacterListViewModelTests: XCTestCase {

    func testIfCharacterListViewModelCanBeInstantiated() {
        // given
        let sut = CharacterListViewModel()
        
        // then
        XCTAssertNotNil(sut)
    }

}
