//
//  MainViewModelTests.swift
//  GithubRxSampleTests
//
//  Created by Alexander Krylov on 15.02.2021.
//  Copyright © 2021 Alexander Krylov. All rights reserved.
//

import XCTest

@testable import GithubRxSample
import RxBlocking

class MainViewModelTests: XCTestCase {
    
    //MARK: Properties
    
    var sut: MainViewModel!
    
    //MARK: Tests
    
    override func setUp() {
        super.setUp()
        sut = MainViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testRelayGetCorrectValue() throws {
        //given
        let newValue = "Swift"
        let relay = sut.selectedLanguage
        
        //when
        relay.accept(newValue)
        
        //then
        let expectation = try relay.toBlocking().last()
        
        XCTAssertEqual(expectation, newValue)
    }
}

