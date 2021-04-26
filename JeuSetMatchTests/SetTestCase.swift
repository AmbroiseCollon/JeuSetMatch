//
//  SetTestCase.swift
//  JeuSetMatchTests
//
//  Created by Breuer Dylan on 18/04/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class SetTestCase: XCTestCase {
    var set: Set!

    override func setUp() {
        super.setUp()
        set = Set()
    }

    func createManyGame(_ count: Int, wonBy player: Player) {
        for _ in 0..<count {
            let game = Game()
            game.winner = player
            set.games.append(game)
        }
    }

    func testGivenPlayerWinsByThreeGamesToTwo_WhenGettingScore_ThenScoreShouldBeThreeToTwo() {
        createManyGame(2, wonBy: .one)
        createManyGame(3, wonBy: .two)

        XCTAssertEqual(set.scores[.one], 2)
        XCTAssertEqual(set.scores[.two], 3)
    }

    func testGivenSetIsNotOver_WhenGettingWinner_ThenWinnerShoudBeNil() {
        XCTAssertNil(set.winner)
    }

    func testGivenPlayer1HasWon6Games_WhenGettingWinner_ThenSetIsOverAndWonByPlayer1() {
        createManyGame(6, wonBy: .one)

        XCTAssertEqual(set.winner, .one)
        XCTAssertTrue(set.isOver)
    }

    func testGivenScoreIs6To5_WhenGettingWinner_ThenNoWinnerAndSetIsNotOver() {
        createManyGame(6, wonBy: .one)
        createManyGame(5, wonBy: .two)

        XCTAssertNil(set.winner)
        XCTAssertFalse(set.isOver)
    }

    func testGivenScoreIs7To6_WhenGettingWinner_ThenPlayer1IsWinnerAndSetIsOver() {
        createManyGame(7, wonBy: .one)
        createManyGame(6, wonBy: .two)

        XCTAssertEqual(set.winner, .one)
        XCTAssertTrue(set.isOver)
    }
}
