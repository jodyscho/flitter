//
//  RealmTweetGatewayTests.swift
//  flitter
//

import XCTest
import Swinject
@testable import flitter


class RealmTweetGatewayTests: XCTestCase {
    let fake = Tweet(value: ["id": "1", "username": "user1", "displayName": "displayname", "text": "tweet text message", "createdAt": Date().timeIntervalSince1970])

    var sut: TweetGateway!
    
    override func setUp() {
        super.setUp()
        Container.defaultContainer.removeAll()
        sut = RealmTweetGateway()
        sut.clear()
    }
    
    override func tearDown() {
        sut.clear()
        sut = nil
        super.tearDown()
    }

    func testFetchEmptyGateway_ReturnsZeroTweets() {
        let exp = expectation(description: "fetch")
        sut.fetchTweets() { (tweets: [Tweet]?) in
            XCTAssertNil(tweets)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testFetchOneTweet_ReturnsOneTweet() {
        sut.save(tweet: fake)
        let exp = expectation(description: "fetch")
        sut.fetchTweets() { (tweets: [Tweet]?) in
            XCTAssertNotNil(tweets)
            XCTAssertEqual(1, tweets?.count)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.5, handler: nil)
    }

    func testClear_RemovesAllTheTweets() {
        sut.save(tweet: fake)
        sut.clear()
        let exp = expectation(description: "fetch")
        sut.fetchTweets() { (tweets: [Tweet]?) in
            XCTAssertNil(tweets)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.5, handler: nil)
    }
}
