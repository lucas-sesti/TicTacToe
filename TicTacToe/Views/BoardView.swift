//
//  BoardView.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 23/11/24.
//

import SwiftUI
import ConfettiSwiftUI

struct BoardView: View {
    @State private var confettiCounter: Int = 0
    @State private var showWinnerView: Bool = false
    @State var board: Board
    
    init(players: [Player]) {
        _board = State(wrappedValue: Board(players: players))
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            
            if board.winner != nil || board.isDraw == true {
                HStack(spacing: 8) {
                    Text("Game over")
                        .font(.system(size: 14, weight: .bold))
                    
                    Button(action: {
                        board.reset()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                    }
                }
                .padding(8)
                .frame(height: 37)
                .background(.gray.opacity(0.1))
                .clipShape(Capsule())
                .foregroundStyle(.primary)
            } else {
                TimerView(
                    board: $board,
                    onPause: {
                        board.pause()
                    }
                )
            }
            
            Spacer()
            
            BoardPlayers(
                players: board.players,
                winner: board.winner?.player,
                currentPlayer: board.currentPlayer
            )
            .frame(maxWidth: 350)
            
            
            Spacer()
                .frame(height: 30)
            
            Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                ForEach(0..<3) { row in
                    RowView(
                        board: board,
                        row: row
                    ) { index in
                        board.makeMove(at: index)
                    }
                }
            }
            .padding()
            .background(.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 23))
            
            
            Spacer()
                .frame(height: 35)
            
            
            Button {
                board.reset()
            } label: {
                Text(board.winner != nil ? "New game" : "Restart game")
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .padding(8)
                    .background(.gray.opacity(0.1))
                    .clipShape(.capsule)
                    .foregroundStyle(Color.primary)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            
        }
        .padding()
        .onChange(of: board.winner) { oldWinner, newWinner in
            if let newWinner = newWinner, newWinner != oldWinner {
                confettiCounter += 1
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    showWinnerView = true
                }
            }
        }
        .confettiCannon(
            counter: $confettiCounter,
            confettiSize: 10,
            radius: 500,
            repetitions: 6,
            repetitionInterval: 0.5
        )
        .task {
            board.startTimer()
        }
        .onDisappear {
            board.stopTimer()
        }
    }
}

#Preview {
    //    let players = [
    //        Player(
    //            name: "Lucas", symbol: .X
    //        ),
    //        Player(
    //            name: "Lavis", symbol: .O
    //        )
    //    ]
    //
    //    BoardView(
    //        board: Board(players: players),
    //        players: players
    //    )
}
