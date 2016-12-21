//
//  Tweet.swift
//  flitter
//

import Foundation


struct Tweet {
    var id: String = UUID.init().uuidString
    var username: String = ""
    var displayName: String = ""
    var text: String = ""
    var createdAt: Double = Date().timeIntervalSince1970
}

extension Tweet {
    init(value: [String: Any]) {
        self.init()
        id = value["id"] as? String ?? self.id
        username = value["username"] as? String ?? self.username
        displayName = value["displayName"] as? String ?? self.displayName
        text = value["text"] as? String ?? self.text
        createdAt = value["createdAt"] as? Double ?? self.createdAt
    }
}
