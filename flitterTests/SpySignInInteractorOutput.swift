//
//  SpySignInInteractorOutput.swift
//  flitter
//

import XCTest
@testable import flitter


class SpySignInInteractorOutput: SignInInteractorOutput {
    var user: User?
    var error: TwitterError?
    var expectation: XCTestExpectation?

    func signInSuccess(user: User) {
        self.user = user
        expectation?.fulfill()
    }
    
    func signInFailure(error: TwitterError) {
        self.error = error
        expectation?.fulfill()
    }
}
