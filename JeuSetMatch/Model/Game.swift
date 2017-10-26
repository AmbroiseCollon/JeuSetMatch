//
//  Model.swift
//  TennisScore
//
//  Created by Ambroise COLLON on 10/10/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import Foundation


import UIKit

enum Player {
    case one, two
}

class Game {
    // MARK: - Subtype points
    enum Points: Int {
        case zero = 0
        case fifteen = 15
        case thirty = 30
        case forty = 40

        static let values: [Points] = [.zero, .fifteen, .thirty, .forty]
    }

    // MARK: - Properties
    var scores = [Player.one: Points.zero, Player.two: Points.zero]
    var winner: Player?

    // MARK: - Methods
    func incrementScore(forPlayer player: Player) {
        if let score = scores[player], score != .forty,
            let scoreIndex = Game.Points.values.index(of: score) {
            scores[player] = Game.Points.values[scoreIndex + 1]
        }
    }
}
