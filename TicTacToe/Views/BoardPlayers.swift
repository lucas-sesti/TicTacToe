//
//  BoardPlayers.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 24/11/24.
//

import SwiftUI

struct BoardPlayers: View {
    var players: [Player]
    var winner: Player?
    var currentPlayer: Player
    
    var body: some View {
        HStack {
            ForEach(players, id: \.self) { player in
                let isWinner = player == winner
                
                HStack {
                    Image(
                        systemName: player.symbol == .X ? "xmark" : "circle"
                    )
                    .font(.system(size: 20))
                    .fontWeight(.black)
                    .foregroundStyle(
                        player.symbol == .X ? Color.ttBlue : Color.ttGreen
                    )
                    
                    Text(player.name)
                        .foregroundStyle(
                            isWinner ? getDarkColor(
                                value: winner?.symbol
                            ) : .primary
                        )
                        .fontWeight(isWinner ? .bold : .regular)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 25)
                .padding(10)
                .background(isWinner ? getLightWinnerColor() : .gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 8))
                .overlay {
                    Group {
                        if isWinner {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    getDarkColor(
                                        value: winner?.symbol
                                    ),
                                    lineWidth: 2
                                )
                                .transition(.scale)
                        }
                        
                        if player == currentPlayer && winner == nil {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    getDarkColor(
                                        value: player.symbol
                                    ),
                                    lineWidth: 2
                                )
                                .transition(.opacity)
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: isWinner || (player == currentPlayer && winner == nil))
                }
                
                if players.first == player {
                    Spacer().frame(width: 24)
                }
            }
        }        
    }
    
    func getLightWinnerColor() -> Color {
        switch winner?.symbol {
        case .X:
            return Color.lightBlue
        case .O:
            return Color.lightGreen
        case .none:
            return .primary
        }
    }
    
    func getDarkColor(value: CellValue?) -> Color {
        switch value {
        case .X:
            return Color.ttBlue
        case .O:
            return Color.ttGreen
        case .none:
            return .primary
        }
    }
}


#Preview {
    BoardPlayers(
        players: [
            Player(
                name: "Lucas", symbol: .X
            ),
            Player(
                name: "Lavis", symbol: .O
            )
        ],
        winner: Player(
            name: "Lucas", symbol: .X
        ),
        currentPlayer:Player(
            name: "Lucas", symbol: .X
        )
    )
}
