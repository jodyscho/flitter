//
//  SignInViewController.swift
//  flitter
//

import UIKit
import RxSwift
import RxCocoa
import Swinject


class SignInViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var wireframe: SignInWireframe!
    var presenter: SignInPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        enableSigninButton()
    }

    fileprivate func configure() {
        let cf = Container.defaultContainer.resolve(SignInConfigurator.self)
        cf?.configure(viewController: self)
    }

    func enableSigninButton() {
        let validUserName = userName.rx.text.map { $0?.characters.count ?? 0 >= 3 }
        let validPassword = password.rx.text.map { $0?.characters.count ?? 0 >= 8 }

        Observable.combineLatest(validUserName, validPassword) { $0 && $1 }
            .bindTo(signInButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }

    @IBAction func signIn(_ sender: Any) {
        presenter.signIn(username: userName.text!, password: password.text!)
    }
}

extension SignInViewController: SignInView {
    
    func dismiss() {
        DispatchQueue.main.async {
            self.wireframe.dismiss()
        }
    }
    
    func displayError(message: String) {
        DispatchQueue.main.async {
            self.wireframe.displayError(message: message)
        }
    }
}
