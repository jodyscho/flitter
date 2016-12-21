//
//  RealmUserGateway.swift
//  flitter
//

import Foundation
import RealmSwift


class RealmUserGateway: UserGateway {

    func save(user: User) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
    }

    func remove() {
        let realm = try! Realm()
        
        let users = realm.objects(User.self)
        try! realm.write {
            users.forEach { realm.delete($0) }
        }
    }
    
    func currentUser() -> User? {
        let realm = try! Realm()
        return realm.objects(User.self).first
    }
}
