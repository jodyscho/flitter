//
//  UserGateway.swift
//  flitter
//

import Foundation

protocol UserGateway {
    func save(user: User)
    func remove()
    func currentUser() -> User?
}
