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

    func testGivenScoreIs40To40_WhenIncrementingPlayer1Score_ThenGameIsNotOverAndThereIsAdvantageForPlayer1() {
        setPlayerOneScore(40)
        setPlayerTwoScore(40)

        game.incrementScore(forPlayer: .one)

        XCTAssertEqual(game.advantagedPlayer, .one)
        XCTAssertNil(game.winner)
        XCTAssertFalse(game.isOver)
    }

    func testGivenPlayer1HasAdvantage_WhenIncrementingPlayer1Score_ThenGameIsOverAndPlayer1IsWinner() {
        setPlayerOneScore(40)
        setPlayerTwoScore(40)
        game.advantagedPlayer = .one

        game.incrementScore(forPlayer: .one)

        XCTAssertEqual(game.winner, .one)
        XCTAssertTrue(game.isOver)
    }

    func testGivenPlayer1HasAdvantage_WhenIncrementingPlayer2Score_ThenNoOneHasAdvantage() {
        setPlayerOneScore(40)
        setPlayerTwoScore(40)
        game.advantagedPlayer = .one

        game.incrementScore(forPlayer: .two)

        XCTAssertNil(game.advantagedPlayer)
        XCTAssertFalse(game.isOver)
    }
}
