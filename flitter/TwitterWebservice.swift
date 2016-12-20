//
//  TwitterWebservice.swift
//  flitter
//

import Foundation

enum TwitterError: Error {
    case invalidUsernamePassword
    case notSignedIn
    case notConnected
    case unknown
}

protocol TwitterWebservice {
    func signin(username: String, password: String, completion: @escaping (User?, TwitterError?) -> ())
    func signout(username: String, completion: @escaping (TwitterError?) -> ())
    func post(tweet: Tweet, completion: @escaping (TwitterError?) -> ())
}
