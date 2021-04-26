//
//  Model.swift
//  TennisScore
//
//  Created by Ambroise COLLON on 10/10/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import Foundation

enum Player {
    case one, two
}

class Game {

    // MARK: - Properties
    private static let points = [0, 15, 30, 40]
    var scores = [Player.one: 0, Player.two: 0]
    var winner: Player?
    var isOver: Bool {
        return winner != nil
    }

    // MARK: - Methods
    func incrementScore(forPlayer player: Player) {
        if let score = scores[player], let scoreIndex = Game.points.firstIndex(of: score) {
            if score < 40 {
                scores[player] = Game.points[scoreIndex + 1]
            } else {
                end(withWinner: player)
            }
        }
    }

    fileprivate func end(withWinner winner: Player) {
        self.winner = winner
    }
}

class TieBreakGame: Game {
    private static let scoreToReach = 7
    private var isTwoPointsAhead: Bool {
        return abs(scores[.one]! - scores[.two]!) >= 2
    }

    override func incrementScore(forPlayer player: Player) {
        scores[player]! += 1

        if scores[player]! >= TieBreakGame.scoreToReach && isTwoPointsAhead {
            end(withWinner: player)
        }
    }
}
