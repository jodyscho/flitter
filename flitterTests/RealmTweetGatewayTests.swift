//
//  RealmTweetGatewayTests.swift
//  flitter
//

import XCTest
@testable import flitter


class RealmTweetGatewayTests: XCTestCase {
    let fake = Tweet(value: ["id": "1", "username": "user1", "displayName": "displayname", "text": "tweet text message", "createdAt": Date().timeIntervalSince1970])

    var sut: TweetGateway!
    
    override func setUp() {
        super.setUp()
        sut = RealmTweetGateway()
        sut.clear()
    }
    
    override func tearDown() {
        sut.clear()
        sut = nil
        super.tearDown()
    }

    func testFetchEmptyGateway_ReturnsZeroTweets() {
        let tweets = sut.fetchTweets()
        XCTAssertNil(tweets)
    }
    
    func testFetchOneTweet_ReturnsOneTweet() {
        sut.save(tweet: fake)
        let tweets = sut.fetchTweets()

        XCTAssertNotNil(tweets)
        XCTAssertEqual(1, tweets?.count)
    }

    func testClear_RemovesAllTheTweets() {
        sut.save(tweet: fake)
        sut.clear()
        let tweets = sut.fetchTweets()

        XCTAssertNil(tweets)
    }
    
    func testSaveAcrossSessions_ReturnsCorrectTweets() {
        sut.save(tweet: fake)
        sut = RealmTweetGateway()
        let tweets = sut.fetchTweets()
        
        XCTAssertNotNil(tweets)
        XCTAssertEqual(1, tweets?.count)
    }
}
