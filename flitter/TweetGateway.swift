//
//  TweetGateway.swift
//  flitter
//

import Foundation


protocol TweetGateway {
    func fetchTweets(completion: @escaping ([Tweet]?) -> ())
    func save(tweets: [Tweet])
    func save(tweet: Tweet)
    func clear()
}
