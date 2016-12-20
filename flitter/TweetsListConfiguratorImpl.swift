//
//  TweetsListConfiguratorImpl.swift
//  flitter
//

import Foundation

class TweetsListConfiguratorImpl: TweetsListConfigurator {
    
    func configure(viewController: TweetsListViewController) {
        configureWireframe(viewController: viewController)
        
        let presenter = configurePresenter(viewController: viewController)
        configureDisplayTweetsInteractor(presenter: presenter)
        configureSignOutInteractor(presenter: presenter)
    }

    fileprivate func configureWireframe(viewController: TweetsListViewController) {
        let wireframe = TweetsListWireframe()
        wireframe.viewController = viewController
        viewController.wireframe = wireframe
    }

    fileprivate func configurePresenter(viewController: TweetsListViewController) -> TweetsListPresenter {
        let presenter = TweetsListPresenter()
        presenter.view = viewController
        viewController.presenter = presenter
        return presenter
    }

    fileprivate func configureDisplayTweetsInteractor(presenter: TweetsListPresenter) {
        let interactor = DisplayTweetsInteractor()
        interactor.output = presenter
        presenter.displayTweetsInteractor = interactor
    }
    
    fileprivate func configureSignOutInteractor(presenter: TweetsListPresenter) {
        let interactor = SignOutInteractor()
        interactor.output = presenter
        presenter.signOutInteractor = interactor
    }
}
