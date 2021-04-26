//
//  GameTestCase.swift
//  JeuSetMatchTests
//
//  Created by Breuer Dylan on 18/04/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class GameTestCase: XCTestCase {
    var game: Game!

    override func setUp() {
        super.setUp()
        game = Game()
    }

    func setPlayerOneScore (_ score: Int) {
        game.scores[.one] = score
    }

    func setPlayerTwoScore (_ score: Int) {
        game.scores[.two] = score
    }

    func testGivenScoreIsNull_WhenIncrementingPlayer1Score_ThenScoreShouldBeFifteen() {

        game.incrementScore(forPlayer: .one)

        XCTAssertEqual(game.scores[.one]!, 15)
        XCTAssertEqual(game.scores[.two]!, 0)
    }

    func testGivenScoreIsFifteen_WhenIncrementingPlayer1Score_ThenScoreShouldBeThirty() {
        setPlayerOneScore(15)

        game.incrementScore(forPlayer: .one)

        XCTAssertEqual(game.scores[.one]!, 30)
        XCTAssertEqual(game.scores[.two]!, 0)
    }

    func testGivenScoreIsThirty_WhenIncrementingPlayer1Score_ThenScoreShouldBeForty() {
        setPlayerOneScore(30)

        game.incrementScore(forPlayer: .one)

        XCTAssertEqual(game.scores[.one]!, 40)
        XCTAssertEqual(game.scores[.two]!, 0)
    }

    func testGivenScoreIsForty_WhenIncrementingPlayer1Score_ThenGameIsOverAndWonByPlayer1() {
        setPlayerOneScore(40)

        game.incrementScore(forPlayer: .one)

        XCTAssertEqual(game.winner, .one)
        XCTAssertTrue(game.isOver)
    }
}
