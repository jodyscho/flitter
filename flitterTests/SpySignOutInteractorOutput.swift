//
//  SpySignOutInteractorOutput.swift
//  flitter
//

import XCTest
@testable import flitter

class SpySignOutInteractorOutput: SignOutInteractorOutput {
    var succeeded: Bool = false
    var error: TwitterError?
    var expectation: XCTestExpectation?
    
    func signOutSucceeded() {
        succeeded = true
        expectation?.fulfill()
    }
    
    func signOutFailed(error: TwitterError) {
        self.error = error
        expectation?.fulfill()
    }
}
