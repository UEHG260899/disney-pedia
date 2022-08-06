//
//  AppConfiguratorTests.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 04/08/22.
//

import XCTest
import RxTest
@testable import DisneyPedia

class AppConfiguratorTests: XCTestCase {
    
    func testIfAppConfiguratorCanBeInstantiated() {
        // given
        let sut = AppConfigurator()
        
        // then
        XCTAssertNotNil(sut)
    }
    
    func testIfAppConfiguratorConfigureNavigationControllerReturnsUINavigationController() {
        // given
        let sut = AppConfigurator.configureNavigationController()
        
        // then
        XCTAssertTrue(sut is UINavigationController)
    }
}
