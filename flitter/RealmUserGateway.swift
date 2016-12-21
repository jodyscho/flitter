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
        let attached = realm.objects(User.self).first
        return detachedUser(user: attached)
    }
}

extension RealmUserGateway {

    fileprivate func detachedUser(user: User?) -> User? {
        guard let user = user else {
            return nil
        }
        
        let detached = User()
        detached.username = user.username
        detached.displayName = user.displayName
        return detached
    }
}
