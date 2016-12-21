//
//  FetchTweetsInteractor.swift
//  flitter
//

import Foundation
import Swinject


class FetchTweetsInteractor {
    let LastFetchTime = "LastFetchTime"
    var tweetGateway: TweetGateway?
    var twitterWebservice: TwitterWebservice?

    init() {
        tweetGateway = Container.defaultContainer.resolve(TweetGateway.self)
        twitterWebservice = Container.defaultContainer.resolve(TwitterWebservice.self)
    }

    func fetchTweets(completion: @escaping ([Tweet]?, TwitterError?) -> ()) {
        let since = lastFetchTime()
        twitterWebservice?.fetchTweets(since: since) { (tweets: [Tweet]?, error: TwitterError?) in
            if let tweets = tweets {
                self.tweetGateway?.save(tweets: tweets)
                self.saveLastFetchTime()
            }
            completion(tweets, error)
        }
    }

    fileprivate func lastFetchTime() -> TimeInterval {
        return UserDefaults.standard.double(forKey: LastFetchTime)
    }
    
    fileprivate func saveLastFetchTime() {
        let now = Date().timeIntervalSince1970 as Double
        UserDefaults.standard.set(now, forKey: LastFetchTime)
    }
}
