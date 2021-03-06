//
//  FakeTwitterWebservice.swift
//  flitter
//

import Foundation


class FakeTwitterWebservice: TwitterWebservice {
    let NetworkDelayInSeconds = 0.3
    
    var passwords: [String: AnyObject]?
    
    init() {
        passwords = loadPasswords()
    }

    func signin(username: String, password: String, completion: @escaping (User?, TwitterError?) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + NetworkDelayInSeconds) {
            guard let userInfo = self.passwords?[username] as? [String : String] else {
                completion(nil, .invalidUsernamePassword)
                return
            }

            if userInfo["password"] == password {
                completion(User(username: userInfo["username"]!, displayName: userInfo["displayName"]!), nil)
            } else {
                completion(nil, .invalidUsernamePassword)
            }
        }
    }
    
    func signout(username: String, completion: @escaping (TwitterError?) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + NetworkDelayInSeconds) {
            completion(nil)
        }
    }
    
    func post(tweet: Tweet, completion: @escaping (TwitterError?) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + NetworkDelayInSeconds) {
            if self.requestShouldFail(percentage: 0.30) {
                completion(.notConnected)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchTweets(since: Double, completion: @escaping ([Tweet]?, TwitterError?) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + NetworkDelayInSeconds) {
            if self.requestShouldFail(percentage: 0.20) {
                completion(nil, .notConnected)
            } else {
                if since == 0 {
                    let loader = TweetLoader()
                    completion(loader.load(resourceName: "newtweets", withExtension: "json"), nil)
                }
            }
        }
    }
}

extension FakeTwitterWebservice {

    fileprivate func requestShouldFail(percentage: Double) -> Bool {
        return Double(arc4random_uniform(100))/100.0 <= percentage
    }
    
    fileprivate func loadPasswords() -> [String: AnyObject]? {
        guard let path = Bundle.main.path(forResource: "passwds", ofType: "plist") else {
            return nil
        }
        return NSDictionary(contentsOfFile: path) as? [String: AnyObject]
    }
}
