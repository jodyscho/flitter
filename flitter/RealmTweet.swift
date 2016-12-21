//
//  RealmTweet.swift
//  flitter
//

import Foundation
import RealmSwift


class RealmTweet: Object {
    dynamic var id: String = UUID.init().uuidString
    dynamic var username: String = ""
    dynamic var displayName: String = ""
    dynamic var text: String = ""
    dynamic var createdAt: Double = Date().timeIntervalSince1970
}

extension RealmTweet {
    convenience init(tweet: Tweet) {
        self.init()
        id = tweet.id
        username = tweet.username
        displayName = tweet.displayName
        text = tweet.text
        createdAt = tweet.createdAt
    }

    func transformToTweet() -> Tweet {
        return Tweet(id: id, username: username, displayName: displayName, text: text, createdAt: createdAt)
    }
}
