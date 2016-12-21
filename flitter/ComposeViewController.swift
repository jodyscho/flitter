//
//  ComposeViewController.swift
//  flitter
//

import UIKit
import RxSwift
import RxCocoa
import Swinject


class ComposeViewController: UIViewController {
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var placeholderText: UILabel!
    @IBOutlet weak var charactersRemaining: UILabel!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    var wireframe: ComposeWireframe!
    var presenter: ComposePresenter!

    let MaxMessageLength: Int = 140
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.layer.borderColor = UIColor.blue.cgColor
        configure()

        listenForTweetTextChanges()
        listenForKeyboardNotifications()
    }
    
    @IBAction func postTweet(_ sender: Any) {
        tweetText.resignFirstResponder()
        presenter.post(text: tweetText.text)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        tweetText.resignFirstResponder()
        if tweetTextIsDirty() {
            wireframe.confirmDismiss()
        } else {
            wireframe.dismiss()
        }
    }

    fileprivate func configure() {
        let cf = Container.defaultContainer.resolve(ComposeConfigurator.self)
        cf?.configure(viewController: self)
    }
    
    fileprivate func tweetTextIsDirty() -> Bool {
        return tweetText.text.characters.count > 0
    }
}

extension ComposeViewController {

    fileprivate func listenForTweetTextChanges() {
        let rx_tweetlength = tweetText.rx.text.map { txt in return (txt?.characters.count) ?? 0 }

        enablePostButton(observable: rx_tweetlength)
        displayPlaceholderText(observable: rx_tweetlength)
        updateTweetLengthCount(observable: rx_tweetlength)
    }
    
    fileprivate func enablePostButton(observable: Observable<String.CharacterView.IndexDistance>) {
        observable.map { count in return count > 0 && count <= self.MaxMessageLength }
            .bindTo(postButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func displayPlaceholderText(observable: Observable<String.CharacterView.IndexDistance>) {
        observable.map { count in return count > 0 }
            .bindTo(placeholderText.rx.isHidden)
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func updateTweetLengthCount(observable: Observable<String.CharacterView.IndexDistance>) {
        observable.map {count in return String(self.MaxMessageLength - count) }
            .bindTo(charactersRemaining.rx.text)
            .addDisposableTo(disposeBag)
    }
}


extension ComposeViewController {
    
    fileprivate func listenForKeyboardNotifications() {
        NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow).subscribe(onNext: { (notification) in
            self.willShowKeyboard(notification: notification)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
        NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillHide).subscribe(onNext: { (notification) in
            self.willHideKeyboard(notification: notification)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func willShowKeyboard(notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        moveTweetButtonContainerView(distanceFromBottom: keyboardSize.height, notification: notification)
    }
    
    fileprivate func willHideKeyboard(notification: Notification) {
        moveTweetButtonContainerView(distanceFromBottom: 0, notification: notification)
    }
    
    fileprivate func moveTweetButtonContainerView(distanceFromBottom: CGFloat, notification: Notification) {
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.2

        bottomConstraint.constant = distanceFromBottom
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ComposeViewController: ComposeView {

    func postSuccessful() {
        DispatchQueue.main.async {
            self.wireframe.dismiss()
        }
    }
    
    func postFailedToSend(message: String) {
        DispatchQueue.main.async {
            self.wireframe.displayError(message: message)
        }
    }
}
