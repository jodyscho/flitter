//
//  ComposeTweetTests.swift
//  flitter
//

import XCTest
import Swinject
@testable import flitter


class ComposeTweetTests: XCTestCase {
    var spyOutput: SpyComposeTweetInteractorOutput!
    var sut: ComposeTweetInteractor!
    
    override func setUp() {
        super.setUp()

        Container.defaultContainer.removeAll()
        Container.defaultContainer.register(UserGateway.self) { _ in AuthenticatedUserGateway() }

        spyOutput = SpyComposeTweetInteractorOutput()
        spyOutput.expectation = expectation(description: "Composing Tweets")
    }
    
    override func tearDown() {
        spyOutput = nil
        sut = nil
        super.tearDown()
    }
    
    func testPost_Succeeds_ProperOutputMethodCalled() {
        Container.defaultContainer.register(TwitterWebservice.self) { _ in SucceedPostingTwitterWebservice() }
        sut = ComposeTweetInteractor()
        sut.output = spyOutput

        sut.post(text: "Test phrase")
        waitForExpectations(timeout: 0.75, handler: nil)
        
        XCTAssertTrue(spyOutput.success)
        XCTAssertNil(spyOutput.error)
    }

    func testPost_Fails_ProperOutputMethodCalled() {
        Container.defaultContainer.register(TwitterWebservice.self) { _ in FailingPostTwitterWebservice() }        
        sut = ComposeTweetInteractor()
        sut.output = spyOutput

        sut.post(text: "Test phrase")
        waitForExpectations(timeout: 0.75, handler: nil)
        
        XCTAssertFalse(spyOutput.success)
        XCTAssertEqual(.unknown, spyOutput.error)
    }
}
