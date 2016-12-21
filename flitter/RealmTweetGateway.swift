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
            let realmTweets = realm.objects(RealmTweet.self).sorted(byProperty: "createdAt", ascending: false)
            
            if realmTweets.count == 0 {
                completion(nil)
                return
            }
            
            completion(realmTweets.map { $0.transformToTweet() })
        }
    }

    func save(tweets: [Tweet]) {
        serialQueue.async {
            let realm = try! Realm()
            try! realm.write {
                tweets.forEach { realm.add(RealmTweet(tweet: $0)) }
            }
        }
    }

    func save(tweet: Tweet) {
        serialQueue.async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(RealmTweet(tweet: tweet))
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
