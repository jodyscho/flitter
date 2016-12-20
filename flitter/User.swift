//
//  User.swift
//  flitter
//

import Foundation
import RealmSwift


class User: Object {
    dynamic var username: String = ""
    dynamic var displayName: String = ""
}
