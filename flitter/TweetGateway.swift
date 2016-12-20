//
//  TweetGateway.swift
//  flitter
//

import Foundation

protocol TweetGateway {
    func fetchTweets() -> [Tweet]?
    func save(tweet: Tweet)
    func clear()
}
