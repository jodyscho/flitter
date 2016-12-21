//
//  TweetsListPresenter.swift
//  flitter
//

import Foundation

protocol TweetsListView: class {
    func displayError(message: String)
    func displaySignIn()
    func clearTweets()
    func displayTweets(tweets: [TweetViewModel]?)
    func appendTweets(tweets: [TweetViewModel])
}

class TweetsListPresenter {
    var fetchTweetsInteractor: FetchTweetsInteractor!
    var loadTweetsInteractor: LoadCachedTweetsInteractor!
    var signOutInteractor: SignOutInteractor!
    weak var view: TweetsListView?
    let dateFormatter = TweetDateFormatter()
    

    func fetchTweets() {
        if CheckSignedInUser.currentUser() == nil {
            view?.displaySignIn()
            return
        }
        
        loadTweetsInteractor.load() {
            if let tweets = $0 {
                self.view?.displayTweets(tweets: tweets.map(self.transform))
            } else {
                self.view?.clearTweets()
            }
        }
        
        fetchTweetsInteractor.fetchTweets() { (tweets: [Tweet]?, error: TwitterError?) in
            guard error == nil else {
                self.view?.displayError(message: "Error getting tweets")
                return
            }

            if let tweets = tweets {
                self.view?.appendTweets(tweets: tweets.map(self.transform).reversed())
            }
        }
    }

    func signOut() {
        signOutInteractor.signOut()
    }
    
    fileprivate func transform(tweet: Tweet) -> TweetViewModel {
        let tweetDate = dateFormatter.formatDate(since1970: tweet.createdAt)
        return TweetViewModel(displayName: tweet.displayName, userName: "@\(tweet.username)", createdDate:tweetDate, tweetText: tweet.text)
    }
}

extension TweetsListPresenter: SignOutInteractorOutput {

    func signOutSucceeded() {
        view?.clearTweets()
        view?.displaySignIn()
    }

    func signOutFailed(error: TwitterError) {
        view?.clearTweets()
        view?.displaySignIn()
    }
}
