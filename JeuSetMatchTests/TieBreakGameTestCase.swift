//
//  TieBreakGameTestCase.swift
//  JeuSetMatchTests
//
//  Created by Breuer Dylan on 25/04/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class TieBreakGameTestCase: XCTestCase {
    var tieBreakGame: TieBreakGame!

    override func setUp() {
        super.setUp()
        tieBreakGame = TieBreakGame()
    }

    func testGivenScoreIs0_WhenIncrementingScore_ThenScoreIs1() {

        tieBreakGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(tieBreakGame.scores[.one], 1)
    }

    func testGivenScoreIs6_WhenIncrementingScore_ThenScoreIs7AndGameIsOver() {
        tieBreakGame.scores[.one] = 6

        tieBreakGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(tieBreakGame.scores[.one], 7)
        XCTAssertTrue(tieBreakGame.isOver)
    }

    func testGivenScoreIs6To6_WhenIncrementingScoreOfPlayer1_ThenScoreIs7To6AndGameIsNotOver() {
        tieBreakGame.scores[.one] = 6
        tieBreakGame.scores[.two] = 6

        tieBreakGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(tieBreakGame.scores[.one], 7)
        XCTAssertEqual(tieBreakGame.scores[.two], 6)
        XCTAssertFalse(tieBreakGame.isOver)
    }

    func testGivenScoreIs7To6_WhenIncrementingScoreOfPlayer1_ThenScoreIs8To6AndGameIsOver() {
        tieBreakGame.scores[.one] = 7
        tieBreakGame.scores[.two] = 6

        tieBreakGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(tieBreakGame.scores[.one], 8)
        XCTAssertEqual(tieBreakGame.scores[.two], 6)
        XCTAssertTrue(tieBreakGame.isOver)
    }
}
