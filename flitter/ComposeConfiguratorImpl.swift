//
//  ComposeConfiguratorImpl.swift
//  flitter
//

import Foundation


class ComposeConfiguratorImpl: ComposeConfigurator {
    
    func configure(viewController: ComposeViewController) {
        let wireframe = ComposeWireframe()
        let presenter = ComposePresenter()
        let interactor = ComposeTweetInteractor()
        
        viewController.wireframe = wireframe
        viewController.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = viewController
        
        interactor.output = presenter

        wireframe.viewController = viewController
    }
}
