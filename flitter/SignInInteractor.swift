//
//  SignInInteractor.swift
//  flitter
//

import Foundation
import Swinject


protocol SignInInteractorOutput: class {
    func signInSuccess(user: User)
    func signInFailure(error: TwitterError)
}

class SignInInteractor {
    weak var output: SignInInteractorOutput?
    var twitterWebservice: TwitterWebservice?
    var userGateway: UserGateway?
    
    init() {
        twitterWebservice = Container.defaultContainer.resolve(TwitterWebservice.self)
        userGateway = Container.defaultContainer.resolve(UserGateway.self)
    }

    func signIn(username: String, password: String) {
        twitterWebservice?.signin(username: username, password: password) { (user, error) in
            guard let user = user else {
                self.signInFailed(error: error)
                return
            }
            self.signInSucceeded(user: user)
        }
    }

    fileprivate func signInFailed(error: TwitterError?) {
        output?.signInFailure(error: error ?? .unknown)
    }

    fileprivate func signInSucceeded(user: User) {
        userGateway?.save(user: user)
        output?.signInSuccess(user: user)
    }
}
