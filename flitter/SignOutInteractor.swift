//
//  SignOutInteractor.swift
//  flitter
//

import Foundation
import Swinject


protocol SignOutInteractorOutput: class {
    func signOutSucceeded()
    func signOutFailed(error: TwitterError)
}

class SignOutInteractor {
    weak var output: SignOutInteractorOutput?
    var twitterWebservice: TwitterWebservice?
    var userGateway: UserGateway?
    var tweetGateway: TweetGateway?

    init() {
        twitterWebservice = Container.defaultContainer.resolve(TwitterWebservice.self)
        userGateway = Container.defaultContainer.resolve(UserGateway.self)
        tweetGateway = Container.defaultContainer.resolve(TweetGateway.self)
    }
    
    func signOut() {
        guard let user = userGateway?.currentUser() else {
            self.signOutFailed(error: .notSignedIn)
            return
        }

        twitterWebservice?.signout(username: user.username) { (error) in
            if error != nil {
                self.signOutFailed(error: error!)
                return
            }
            self.signOutSucceeded()
        }
    }

    fileprivate func signOutFailed(error: TwitterError) {
        clearUserData()
        output?.signOutFailed(error: error)
    }

    fileprivate func signOutSucceeded() {
        clearUserData()
        output?.signOutSucceeded()
    }
    
    fileprivate func clearUserData() {
        userGateway?.remove()
        tweetGateway?.clear()
    }
}
