//
//  Board.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 23/11/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
class Board {
    var cells: [CellValue?];
    var xIsNext: Bool
    var winner: Winner?
    var players: [Player]
    var timeRemaining = 30
    var isPaused = false
    var timer: Timer? = nil
    var progress: CGFloat = 1.0
    var totalTime = 30
    var isDraw: Bool = false
    
    init(players: [Player]) {
        self.cells = Array(repeating: nil as CellValue?, count: 9)
        self.xIsNext = true
        self.winner = nil
        self.players = players
    }
    
    var currentPlayer: Player {
        get {
            return xIsNext ? players.first! : players.last!
        }
    }
    
    func makeMove(at index: Int) -> Void {
        if cells[index] != nil {
            return
        }
        
        if winner != nil {
            return
        }
        
        cells[index] = currentPlayer.symbol
        xIsNext = !xIsNext
        winner = calculateWinner()
        
        if winner == nil && !cells.contains(nil) {
            isDraw = true
            stopTimer()
        }
        
        restartTimer()
    }
    
    func calculateWinner() -> Winner? {
        let lines: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Horizontais
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Verticais
            [0, 4, 8], [2, 4, 6]             // Diagonais
        ];
        
        for line in lines {
            let a = line[0]
            let b = line[1]
            let c = line[2]
            
            if cells[a] != nil && cells[a] == cells[b] && cells[a] == cells[c] {
                stopTimer()
                
                return Winner(
                    player: players.first { $0.symbol == cells[a] }!,
                    cells: [a,b,c]
                )
            }
        }
        
        return nil;
    }
    
    func reset() -> Void {
        cells = Array(repeating: nil as CellValue?, count: 9)
        xIsNext = true
        winner = nil
        isDraw = false
        
        restartTimer()
    }
    
    func startTimer() {
        stopTimer()
        timeRemaining = totalTime
        progress = 1.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.isPaused {
                return
            }
            
            if self.timeRemaining > 0 {
                withAnimation {
                    self.timeRemaining -= 1
                    self.progress = CGFloat(self.timeRemaining) / CGFloat(self.totalTime)
                }
            } else {
                timer.invalidate()
                
                self.xIsNext = !self.xIsNext
                self.restartTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer() {
        withAnimation {
            isPaused = false
            startTimer()
        }
    }
    
    func pause() {
        withAnimation {
            isPaused = !isPaused
        }
    }
}
