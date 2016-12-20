//
//  FailingPostTwitterWebservice.swift
//  flitter
//

import XCTest
@testable import flitter


class FailingPostTwitterWebservice: TwitterWebservice {
    func signin(username: String, password: String, completion: @escaping (User?, TwitterError?) -> ()) {
    }
    
    func signout(username: String, completion: @escaping (TwitterError?) -> ()) {
    }
    
    func post(tweet: Tweet, completion: @escaping (TwitterError?) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            completion(.unknown)
        }
    }
}
