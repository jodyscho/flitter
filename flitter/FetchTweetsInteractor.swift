//
//  FetchTweetsInteractor.swift
//  flitter
//

import Foundation
import Swinject


protocol FetchTweetsInteractorOutput: class {
    
}

class FetchTweetsInteractor {
    weak var output: FetchTweetsInteractorOutput?
    var tweetGateway: TweetGateway?
    var lastFetchTime: TimeInterval!

    init() {
        tweetGateway = Container.defaultContainer.resolve(TweetGateway.self)
    }

    func fetchTweets(completion: ([Tweet]?) -> ()) {
        lastFetchTime = UserDefaults.standard.double(forKey: "LastFetchTime")

    }
}
