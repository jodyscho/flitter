//
//  ComposeTweetInteractor.swift
//  flitter
//

import Foundation
import Swinject


protocol ComposeTweetInteractorOutput: class {
    func postSuccess()
    func postFailure(error: TwitterError)
}


class ComposeTweetInteractor {
    weak var output: ComposeTweetInteractorOutput?
    var twitterWebservice: TwitterWebservice?
    var userGateway: UserGateway?
    var tweetGateway: TweetGateway?
    
    init() {
        twitterWebservice = Container.defaultContainer.resolve(TwitterWebservice.self)
        userGateway = Container.defaultContainer.resolve(UserGateway.self)
        tweetGateway = Container.defaultContainer.resolve(TweetGateway.self)
    }
    
    func post(text: String) {
        guard let user = userGateway?.currentUser() else {
            postFailed(error: .invalidUsernamePassword)
            return
        }
        
        let tweet = buildTweet(user: user, text: text)
        
        twitterWebservice?.post(tweet: tweet) { (error) in
            if error != nil {
                self.postFailed(error: error!)
                return
            }
            self.postSucceeded(tweet: tweet)
        }
    }
    
    fileprivate func buildTweet(user: User, text: String) -> Tweet {
        return Tweet(value: ["id": UUID.init().uuidString, "username": user.username, "displayName": user.displayName, "text": text, "createdAt": Date().timeIntervalSince1970] )
    }
    
    fileprivate func postFailed(error: TwitterError) {
        output?.postFailure(error: error)
    }
    
    fileprivate func postSucceeded(tweet: Tweet) {
        tweetGateway?.save(tweet: tweet)
        output?.postSuccess()
    }
}
