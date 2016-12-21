//
//  RealmTweetGateway.swift
//  flitter
//

import Foundation
import RealmSwift


class RealmTweetGateway: TweetGateway {
    let serialQueue = DispatchQueue(label: "RealmTweetGateway")
    
    func fetchTweets(completion: @escaping ([Tweet]?) -> ()) {
        serialQueue.async {
            let realm = try! Realm()
            let tweets = realm.objects(Tweet.self).sorted(byProperty: "createdAt", ascending: false)
            
            if tweets.count == 0 {
                completion(nil)
                return
            }
            
            var result = [Tweet]()
            for tweet in tweets {
                result.append(tweet)
            }
            completion(result)
        }
    }

    func save(tweets: [Tweet]) {
        serialQueue.async {
            let realm = try! Realm()
            try! realm.write {
                tweets.forEach { realm.add($0) }
            }
        }
    }

    func save(tweet: Tweet) {
        serialQueue.async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(tweet)
            }
        }
    }

    func clear() {
        serialQueue.async {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
    }
}
