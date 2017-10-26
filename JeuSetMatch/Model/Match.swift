//
//  Match.swift
//  Jeu Set & Match
//
//  Created by Ambroise COLLON on 19/10/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import Foundation

class Match {
    // MARK: - Properties
    var sets = [Set()]

    var winner: Player? {
        return getWinner()
    }

    var isOver: Bool {
        return winner != nil
    }

    var scores: [Player: Int] {
        return getScores()
    }

    var currentGame: Game {
        return sets.last!.games.last!
    }

    private var currentSet: Set {
        return sets.last!
    }

    // MARK: - Private Getters
    private func getWinner() -> Player? {
        if scores[.one] == 3 {
            return .one
        } else if scores[.two] == 3 {
            return .two
        }
        return nil
    }
    
    private func getScores() -> [Player: Int] {
        var scores = [Player.one: 0, Player.two: 0]

        for set in sets {
            if let setWinner = set.winner {
                scores[setWinner]! += 1
            }
        }
        return scores
    }

    // MARK: - Methods
    func pointEnded(wonBy player: Player) {
        if !isOver, let score = currentGame.scores[player] {
            if score == Game.Points.forty {
                endCurrentGame(wonBy: player)
            } else {
                currentGame.incrementScore(forPlayer: player)
            }
        }
    }

    private func endCurrentGame(wonBy player: Player) {
        currentGame.winner = player
        if currentSet.isOver {
            if !isOver {
                addNewSetToMatch()
            }
        } else {
	        addNewGameToCurrentSet()
        }
    }

    private func addNewGameToCurrentSet() {
        currentSet.games.append(Game())
    }

    private func addNewSetToMatch() {
        sets.append(Set())
    }
}
