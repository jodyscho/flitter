//
//  UserGatewayTests.swift
//  flitter
//

import XCTest
@testable import flitter

class UserGatewayTests: XCTestCase {
    var sut: UserGateway!
    
    override func setUp() {
        super.setUp()
        sut = RealmUserGateway()
        sut.remove()
    }
    
    override func tearDown() {
        sut.remove()
        super.tearDown()
    }

    func testCurrentUser_DoesnotExist_AtFirst() {
        let currentUser = sut.currentUser()
        XCTAssertNil(currentUser)
    }
    
    func testSaveUser() {
        let user = User(value: ["username": "username", "displayName": "Display Name"])
        sut.save(user: user)
        
        let currentUser = sut.currentUser()
        XCTAssertEqual(user.username, currentUser?.username)
    }

    func testRemoveUser() {
        let user = User(value: ["username": "username", "displayName": "Display Name"])

        sut?.save(user: user)
        sut?.remove()

        let currentUser = sut?.currentUser()
        XCTAssertNil(currentUser)
    }
}
