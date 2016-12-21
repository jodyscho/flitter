//
//  Tweet.swift
//  flitter
//

import Foundation
import RealmSwift


class Tweet: Object {
    dynamic var id: String = UUID.init().uuidString
    dynamic var username: String = ""
    dynamic var displayName: String = ""
    dynamic var text: String = ""
    dynamic var createdAt: Double = Date().timeIntervalSince1970
}
