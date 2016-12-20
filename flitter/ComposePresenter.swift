//
//  ComposePresenter.swift
//  flitter
//

import Foundation

protocol ComposeView: class {
    func postSuccessful()
    func postFailedToSend(message: String)
}


class ComposePresenter {
    var interactor: ComposeTweetInteractor!
    weak var view: ComposeView?
    
    func post(text: String) {
        interactor.post(text: text)
    }
}

extension ComposePresenter: ComposeTweetInteractorOutput {

    func postSuccess() {
        view?.postSuccessful()
    }
    
    func postFailure(error: TwitterError) {
        view?.postFailedToSend(message: "Unable to post tweet!")
    }
}
