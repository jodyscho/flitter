//
//  InMemoryTwitterWebservice.swift
//  flitter
//

import Foundation


class InMemoryTwitterWebservice: TwitterWebservice {
    let NetworkDelayInSeconds = 0.3
    
    var passwords: [String: AnyObject]?
    
    init() {
        passwords = loadPasswords()
    }

    fileprivate func loadPasswords() -> [String: AnyObject]? {
        guard let path = Bundle.main.path(forResource: "passwds", ofType: "plist") else {
            return nil
        }
        return NSDictionary(contentsOfFile: path) as? [String: AnyObject]
    }
    
    func signin(username: String, password: String, completion: @escaping (User?, TwitterError?) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + NetworkDelayInSeconds) {
            guard let userInfo = self.passwords?[username] else {
                completion(nil, .invalidUsernamePassword)
                return
            }
            
            if userInfo["password"] as? String == password {
                completion(User(value: userInfo as! [String : String]), nil)
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
    
    fileprivate func requestShouldFail(percentage: Double) -> Bool {
        return Double(arc4random_uniform(100))/100.0 <= percentage
    }
}
