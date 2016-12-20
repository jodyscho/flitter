//
//  CheckSignedInUser.swift
//  flitter
//

import Foundation
import Swinject


class CheckSignedInUser {
    
    static func currentUser() -> User? {
        let userGateway = Container.defaultContainer.resolve(UserGateway.self)
        return userGateway?.currentUser()
    }
}
