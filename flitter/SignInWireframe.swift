//
//  SignInWireframe.swift
//  flitter
//

import UIKit

class SignInWireframe {
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error Signing In", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
