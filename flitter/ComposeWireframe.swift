//
//  ComposeWireframe.swift
//  flitter
//

import UIKit

class ComposeWireframe {
    weak var viewController: UIViewController?
    
    func confirmDismiss() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.dismiss()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }

    func displayError(message: String) {
        let alert = UIAlertController(title: "Error Posting Tweet", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }

    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
