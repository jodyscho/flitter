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
        
//        let tweet1 = TweetViewModel(displayName: "Jody Schofield", userName: "@jodyscho", createdDate:"2 days", tweetText: "Like any other social media site Facebook has length requirements when it comes to writing on the wall, providing status, messaging and commenting. Understanding how many characters you can use, enables you to more effectively use Facebook as a business or campaign tool.")
//        let tweet2 = TweetViewModel(displayName: "Jody Schofield", userName: "@jodyscho", createdDate:"2 days", tweetText: "Merry Christmas everyone.")
//        
//        view?.appendTweets(tweets: [tweet1, tweet2])
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
