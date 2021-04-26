//
//  MatchTestCase.swift
//  JeuSetMatchTests
//
//  Created by Breuer Dylan on 18/04/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class MatchTestCase: XCTestCase {
    var match: Match!

    override func setUp() {
        match = Match()
    }

    func createManyGame(_ count: Int, wonBy player: Player, in set: Set) {
        for _ in 0..<count {
            let game = Game()
            game.winner = player
            set.games.append(game)
        }
    }

    func createSet(wonBy player: Player) -> Set {
        let set = Set()
        createManyGame(6, wonBy: player, in: set)
        return set
    }

    func createManySets(_ count: Int, wonBy player: Player) {
        for _ in 0..<count {
            let set = createSet(wonBy: player)
            match.sets.append(set)
        }
    }

    func testGivenCurrentGameScoreIsNull_WhenPointIsAddedToPlayer1_ScoreIsOnlyIncremented() {
        match.pointEnded(wonBy: .one)

        XCTAssertEqual(match.sets.count, 1)
        XCTAssertEqual(match.sets.last!.games.count, 1)
        XCTAssertEqual(match.currentGame.scores[.one]!, 15)
    }

    func testGivenCurrentGameScoreIsForty_WhenPointIsAdded_GameIsEndedAndNewGameIsCreated() {
        match.currentGame.scores[.one] = 40

        match.pointEnded(wonBy: .one)

        XCTAssertTrue(match.sets.last!.games.first!.isOver)
        XCTAssertEqual(match.sets.last!.games.count, 2)
    }

    func testGivenCurrentGameScoreIsFortyAndSetScoreIs5_WhenPointIsAdded_SetIsEndedAndNewSetIsCreated() {
        createManyGame(5, wonBy: .one, in: match.sets.last!)
        match.sets.last?.games.append(Game())
        match.currentGame.scores[.one] = 40

        match.pointEnded(wonBy: .one)

        XCTAssertTrue(match.sets.first!.isOver)
        XCTAssertEqual(match.sets.count, 2)
    }

    func testGivenPlayer1HasWonThreeSets_WhenGettingWinner_ThenMatchIsOverAndWonByPlayer1() {
        createManySets(3, wonBy: .one)

        XCTAssertTrue(match.isOver)
        XCTAssertEqual(match.winner, .one)
    }

    func testGivenCurrentGameScoreIsFortyAndSetScoreIs5To6_WhenPointIsAddedToPlayer1_ThenTieBreakGameIsCreated() {
        createManyGame(5, wonBy: .one, in: match.sets.last!)
        createManyGame(6, wonBy: .two, in: match.sets.last!)
        match.sets.last?.games.append(Game())
        match.currentGame.scores[.one] = 40

        match.pointEnded(wonBy: .one)

        XCTAssert(match.currentGame is TieBreakGame)
    }
}
