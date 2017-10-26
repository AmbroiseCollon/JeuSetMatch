//
//  ViewController.swift
//  TennisScore
//
//  Created by Ambroise COLLON on 10/10/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var player1SetScoreLabels: [UILabel]!
    @IBOutlet var player2SetScoreLabels: [UILabel]!
    lazy var playerSetScoreLabels: [Player: [UILabel]] = [Player.one: player1SetScoreLabels, Player.two: player2SetScoreLabels]

    @IBOutlet weak var player1GameScoreLabel: UILabel!
    @IBOutlet weak var player2GameScoreLabel: UILabel!
    lazy var playerGameScoreLabels: [Player: UILabel] = [Player.one: player1GameScoreLabel, Player.two: player2GameScoreLabel]

    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    @IBOutlet weak var newGameButton: UIButton!

    // MARK: - Properties
    var match = Match()

    // MARK: - Actions
    @IBAction func addPointToPlayer1() {
        match.pointEnded(wonBy: Player.one)
        updateUI()
    }

    @IBAction func addPointToPlayer2() {
        match.pointEnded(wonBy: Player.two)
        updateUI()
    }

    @IBAction func startNewGame() {
        match = Match()
        updateUI()
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        updateScoreUI(forPlayer: .one)
        updateScoreUI(forPlayer: .two)
        updateInfoUI()
    }

    private func updateScoreUI(forPlayer player: Player) {
        updateAllSetsScore(forPlayer: player)
        updateGameScore(forPlayer: player)
    }

    private func updateAllSetsScore(forPlayer player: Player) {
        for i in 0..<6 {
            if i < match.sets.count {
                let set = match.sets[i]
                playerSetScoreLabels[player]![i].text = "\(set.scores[player]!)"
            } else {
                playerSetScoreLabels[player]![i].text = ""
            }
        }
    }

    private func updateGameScore(forPlayer player: Player) {
        let gameScore = match.currentGame.scores[player]
        playerGameScoreLabels[player]!.text = "\(gameScore!)"
    }

    private func updateInfoUI() {
        if match.winner != nil {
            setWinnerUI()
        } else {
            setOngoingGameUI()
        }
    }

    private func setWinnerUI() {
        player1Button.isHidden = true
        player2Button.isHidden = true
        newGameButton.isHidden = false

        infoLabel.text = getWinnerDisplayText()
    }

    private func getWinnerDisplayText() -> String? {
        if let winner = match.winner {
            var winnerDisplayText = "Jeu, set et match ! Le joueur "
            winnerDisplayText += (winner == .one) ? "1" : "2"
            winnerDisplayText += " a gagné !"

            return winnerDisplayText
        }

        return nil
    }

    private func setOngoingGameUI() {
        player1Button.isHidden = false
        player2Button.isHidden = false
        newGameButton.isHidden = true

        infoLabel.text = "Qui a gagné le point ?"
    }
}

