//
//  AppDelegate.swift
//  flitter
//

import UIKit
import Swinject


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setUpDependencyInjection()
        return true
    }
    
    fileprivate func setUpDependencyInjection() {
        Container.defaultContainer.register(SignInConfigurator.self) { _ in SignInConfiguratorImpl() }
        Container.defaultContainer.register(TweetsListConfigurator.self) { _ in TweetsListConfiguratorImpl() }
        Container.defaultContainer.register(ComposeConfigurator.self) { _ in ComposeConfiguratorImpl() }
        Container.defaultContainer.register(UserGateway.self) { _ in RealmUserGateway() }
        Container.defaultContainer.register(TwitterWebservice.self) { _ in FakeTwitterWebservice() }
        Container.defaultContainer.register(TweetGateway.self) { _ in RealmTweetGateway() }
    }
}

