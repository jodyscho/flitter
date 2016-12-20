//
//  Tweet.swift
//  flitter
//

import Foundation
import RealmSwift


class Tweet: Object {
    dynamic var id: String = ""
    dynamic var username: String = ""
    dynamic var displayName: String = ""
    dynamic var text: String = ""
    dynamic var createdAt: Double = 0
}
