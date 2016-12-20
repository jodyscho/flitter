//
//  RealmUserGateway.swift
//  flitter
//

import Foundation
import RealmSwift


class RealmUserGateway: UserGateway {
    
    func save(user: User) {
        guard currentUser() == nil else {
            return
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
    }
    
    func remove() {
        guard let user = currentUser() else {
            return
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func currentUser() -> User? {
        let realm = try! Realm()
        return realm.objects(User.self).first
    }
}
