//
//  RealmTweetGateway.swift
//  flitter
//

import Foundation
import RealmSwift


class RealmTweetGateway: TweetGateway {
    
    init() {
    }

    func fetchTweets() -> [Tweet]? {
        let realm = try! Realm()
        let tweets = realm.objects(Tweet.self).sorted(byProperty: "createdAt")

        if tweets.count == 0 {
            return nil
        }

        var result = [Tweet]()
        for tweet in tweets {
            result.append(tweet)
        }
        return result
    }

    func save(tweet: Tweet) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(tweet)
        }
    }

    func clear() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
