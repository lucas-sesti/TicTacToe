//
//  RowView.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 23/11/24.
//

import SwiftUI

struct RowView: View {
    var board: Board
    var row: Int
    var onSelect: (_ index: Int) -> Void
    
    var body: some View {
        GridRow {
            ForEach(0..<3) { column in
                let index = row * 3 + column
                
                CellView(
                    value: board.cells[index],
                    isWinnerCell: board.winner?.cells.contains(index) ?? false
                )
                .frame(
                    width: 100,
                    height: 100,
                    alignment: .center
                )
                .onTapGesture {
                    onSelect(index)
                }
            }
        }
    }
}

#Preview {
    RowView(
        board: Board(
            players: []
        ),
        row: 0,
        onSelect: { index in
            
        }
    )
}
