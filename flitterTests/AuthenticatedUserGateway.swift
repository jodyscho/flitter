//
//  AuthenticatedUserGateway.swift
//  flitter
//

import XCTest
@testable import flitter

class AuthenticatedUserGateway: UserGateway {
    var saveCalled: Int = 0
    var removeCalled: Int = 0
    
    func save(user: User) {
        saveCalled += 1
    }
    
    func remove() {
        removeCalled += 1
    }
    
    func currentUser() -> User? {
        return User(value: ["username": "User", "displayName": "Display Name"])
    }
}

