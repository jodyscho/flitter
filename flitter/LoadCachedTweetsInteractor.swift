//
//  LoadCachedTweetsInteractor.swift
//  flitter
//

import Foundation
import Swinject


class LoadCachedTweetsInteractor {
    let FirstTimeLoading = "FirstTimeLoading"
    var tweetGateway: TweetGateway?
    
    init() {
        tweetGateway = Container.defaultContainer.resolve(TweetGateway.self)
    }

    func load(completion: @escaping ([Tweet]?) -> ()) {
        if firstTimeLoading() {
            populateCache()
        }
        tweetGateway?.fetchTweets(completion: completion)
    }
    
    fileprivate func firstTimeLoading() -> Bool {
        guard UserDefaults.standard.value(forKey: FirstTimeLoading) != nil else {
            return true
        }
        return false
    }
    
    fileprivate func populateCache() {
        let loader = TweetLoader()
        guard let tweets = loader.load(resourceName: "oldtweets", withExtension: "json") else {
            return
        }
        
        tweetGateway?.save(tweets: tweets)
        UserDefaults.standard.set(true, forKey: FirstTimeLoading)
    }
}
