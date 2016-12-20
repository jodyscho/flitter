//
//  SignInConfiguratorImpl.swift
//  flitter
//

import Foundation

class SignInConfiguratorImpl: SignInConfigurator {
    
    func configure(viewController: SignInViewController) {
        let wireframe = SignInWireframe()
        let presenter = SignInPresenter()
        let interactor = SignInInteractor()
        
        viewController.wireframe = wireframe
        viewController.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = viewController
        
        interactor.output = presenter
        
        wireframe.viewController = viewController
    }
}
