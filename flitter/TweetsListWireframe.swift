//
//  TweetsListWireframe.swift
//  flitter
//

import UIKit

class TweetsListWireframe {
    weak var viewController: UIViewController?
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }

    func displaySignIn() {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() else {
            return
        }

        viewController?.present(vc, animated: true, completion: nil)
    }
}
