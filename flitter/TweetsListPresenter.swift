//
//  TweetsListPresenter.swift
//  flitter
//

import Foundation

protocol TweetsListView: class {
    func displaySignIn()
    func clearTweets()
    func displayTweets(tweets: [TweetViewModel]?)
}

class TweetsListPresenter {
    var fetchTweetsInteractor: FetchTweetsInteractor!
    var loadTweetsInteractor: LoadCachedTweetsInteractor!
    var signOutInteractor: SignOutInteractor!
    weak var view: TweetsListView?
    
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
    }

    func signOut() {
        signOutInteractor.signOut()
    }
    
    fileprivate func transform(tweet: Tweet) -> TweetViewModel {
        let tweetDate = "2 days"
        return TweetViewModel(displayName: tweet.displayName, userName: "@\(tweet.username)", createdDate:tweetDate, tweetText: tweet.text)
    }
}

extension TweetsListPresenter: FetchTweetsInteractorOutput {
    
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
