//
//  NetworkerTests.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import DisneyPedia

class NetworkerTests: XCTestCase {
    
    
    let validRequest = URLRequest(url: URL(string: "https://api.disneyapi.dev/characters?page=1")!)
    var erroredCorrectly: Bool!
    
    
    override func setUp() {
        super.setUp()
        erroredCorrectly = false
    }
    
    override func tearDown() {
        erroredCorrectly = nil
        super.tearDown()
    }
    
    // MARK: - When functions
    private func whenResponse(for request: URLRequest) -> Observable<(HTTPURLResponse, Data)> {
        return Networker.response(request: request)
    }
    
    func testIfNetworkerCanBeInstantiated() {
        // given
        let sut = Networker()
        
        // then
        XCTAssertNotNil(sut)
    }
    
    func testWhenResponseMethodCalledWithValidRequestReturnsObservable() {
        // when
        let observable = whenResponse(for: validRequest)
        
        // then
        XCTAssertNotNil(try observable.toBlocking().first())
    }
    
    func testWhenResponseMethodCalledWithInvalidRequestReturnsError() {
        // given
        let request = URLRequest(url: URL(string: "hola")!)
        
        // when
        let observable = whenResponse(for: request)
        
        do {
            _ = try observable.toBlocking().first()
        } catch {
            erroredCorrectly = true
        }
        
        // then
        XCTAssertTrue(erroredCorrectly)
    }
    
    func testWhenDataMethodCalledWithValidResponseReturnsObservable() {
        // when
        let observable = Networker.data(request: validRequest)
        
        // then
        XCTAssertNotNil(try observable.toBlocking().first())
    }
    
    func testWhenDataMethodCalledWithInvalidRequestThrowsRequestFailedError() {
        // given
        let request = URLRequest(url: URL(string: "https://api.disneyapi.dev/chracters?page=200")!)
        
        // when
        let observable = Networker.data(request: request)
        
        do {
            _ = try observable.toBlocking().first()
        } catch {
            erroredCorrectly = true
        }
        
        // then
        XCTAssertTrue(erroredCorrectly)
    }
    
    func testWhenDecodableMethodIsCalledWithValidResponseReturnsObservable() {
        // when
        let observable = Networker.decodable(request: validRequest, type: CorrectCharacterList.self)
        
        // then
        XCTAssertNotNil(try observable.toBlocking().first())
    }
    
    func testWhenDecodableMethodIsCalledWithInvalidTypeThrowsDeserializationError() {
        // when
        let observable = Networker.decodable(request: validRequest, type: IncorrectCharacterList.self)
        
        do {
            _ = try observable.toBlocking().first()
        } catch Networker.NetworkerErrors.deserializationFailed {
            erroredCorrectly = true
        } catch {
            assertionFailure()
        }
        
        // then
        XCTAssertTrue(erroredCorrectly)
    }
    
}
