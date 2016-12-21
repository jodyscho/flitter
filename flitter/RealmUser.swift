//
//  RealmUser.swift
//  flitter
//

import Foundation
import RealmSwift


class RealmUser: Object {
    dynamic var username: String = ""
    dynamic var displayName: String = ""
}

extension RealmUser {
    convenience init(user: User) {
        self.init()
        username = user.username
        displayName = user.displayName
    }

    func transformToUser() -> User {
        return User(username: username, displayName: displayName)
    }
}
