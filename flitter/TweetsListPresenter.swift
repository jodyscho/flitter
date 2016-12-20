//
//  TweetsListPresenter.swift
//  flitter
//

import Foundation

protocol TweetsListView: class {
    func displaySignIn()
    func clearTweets()
    func appendTweets(tweets: [TweetViewModel])
}

class TweetsListPresenter {
    var displayTweetsInteractor: DisplayTweetsInteractor!
    var signOutInteractor: SignOutInteractor!
    weak var view: TweetsListView?
    
    func fetchTweets() {
        if CheckSignedInUser.currentUser() == nil {
            view?.displaySignIn()
            return
        }
        
        view?.appendTweets(tweets: [TweetViewModel(displayName: "Jody Schofield", userName: "@jodyscho", createdDate:"2 days", tweetText: "Merry Christmas everyone")])
    }

    func signOut() {
        signOutInteractor.signOut()
    }
}

extension TweetsListPresenter: DisplayTweetsInteractorOutput {
    
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
