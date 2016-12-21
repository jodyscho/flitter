//
//  SignOutTests.swift
//  flitter
//

import XCTest
import Swinject
@testable import flitter


class SignOutTests: XCTestCase {
    var sut: SignOutInteractor!
    var spyOutput: SpySignOutInteractorOutput!
    
    override func setUp() {
        super.setUp()

        Container.defaultContainer.removeAll()
        Container.defaultContainer.register(TwitterWebservice.self) { _ in FakeTwitterWebservice() }

        spyOutput = SpySignOutInteractorOutput()
        spyOutput.expectation = expectation(description: "Failure on SignOut")
    }

    override func tearDown() {
        Container.defaultContainer.removeAll()
        sut = nil
        spyOutput = nil
        super.tearDown()
    }

    func testSignOut_WhenNotSignedIn_ReturnsError() {
        let unauthUserGateway = UnauthenticatedUserGateway()
        Container.defaultContainer.register(UserGateway.self) { _ in unauthUserGateway }
        sut = SignOutInteractor()
        sut.output = spyOutput

        sut.signOut()
        waitForExpectations(timeout: 0.5, handler: nil)

        XCTAssertEqual(TwitterError.notSignedIn, spyOutput.error)
    }
    
    func testSignOut_WhenSignedIn_RemovesCurrentUser() {
        let authUserGateway = AuthenticatedUserGateway()
        Container.defaultContainer.register(UserGateway.self) { _ in authUserGateway }
        sut = SignOutInteractor()
        sut.output = spyOutput
        
        sut.signOut()
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertTrue(spyOutput.succeeded)
        XCTAssertEqual(1, authUserGateway.removeCalled)
    }
}
