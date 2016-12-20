//
//  SpyComposeTweetInteractorOutput.swift
//  flitter
//

import XCTest
@testable import flitter


class SpyComposeTweetInteractorOutput: ComposeTweetInteractorOutput {
    var success: Bool = false
    var error: TwitterError?
    var expectation: XCTestExpectation?
    
    func postSuccess() {
        success = true
        expectation?.fulfill()
    }
    
    func postFailure(error: TwitterError) {
        self.error = error
        expectation?.fulfill()
    }
}
