//
//  TweetsListWireframe.swift
//  flitter
//

import UIKit

class TweetsListWireframe {
    weak var viewController: UIViewController?
    
    func displaySignIn() {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() else {
            return
        }

        viewController?.present(vc, animated: true, completion: nil)
    }
}
