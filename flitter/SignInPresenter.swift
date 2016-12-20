//
//  SignInPresenter.swift
//  flitter
//

import Foundation

protocol SignInView: class {
    func dismiss()
    func displayError(message: String)
}


class SignInPresenter {
    var interactor: SignInInteractor!
    weak var view: SignInView?
    
    func signIn(username: String, password: String) {
        interactor.signIn(username: username, password: password)
    }
}

extension SignInPresenter: SignInInteractorOutput {
    
    func signInSuccess(user: User) {
        view?.dismiss()
    }
    
    func signInFailure(error: TwitterError) {
        view?.displayError(message: "Invalid username or password")
    }
}
