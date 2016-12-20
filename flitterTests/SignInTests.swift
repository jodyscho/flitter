//
//  SignInTests.swift
//  flitter
//

import XCTest
import Swinject
@testable import flitter


class SignInTests: XCTestCase {
    var sut: SignInInteractor!
    var spyOutput: SpySignInInteractorOutput!

    override func setUp() {
        super.setUp()
        Container.defaultContainer.removeAll()
        Container.defaultContainer.register(TwitterWebservice.self) { _ in InMemoryTwitterWebservice() }
        setUpSUT()
    }
    
    override func tearDown() {
        Container.defaultContainer.removeAll()
        sut = nil
        spyOutput = nil
        super.tearDown()
    }

    fileprivate func setUpSUT() {
        spyOutput = SpySignInInteractorOutput()
        spyOutput.expectation = expectation(description: "Failure on SignIn")
        
        sut = SignInInteractor()
        sut.output = spyOutput
    }

    func testSignIng_InValidUser_ReturnsError() {
        sut.signIn(username: "nobody", password: "doesntmatter")
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertNotNil(spyOutput.error)
    }
    
    func testSignIn_ValidUserInvalidPassword_ReturnsError() {
        sut.signIn(username: "flitter", password: "doesntmatter")
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertNotNil(spyOutput.error)
    }
    
    func testSignIn_ValidUserValidPassword_ReturnsSuccess() {
        sut.signIn(username: "flitter", password: "flitter123!")
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertNotNil(spyOutput.user)
    }
}
