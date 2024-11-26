////
////  WinnerView.swift
////  TicTacToe
////
////  Created by Lucas Sesti on 24/11/24.
////
//
//import SwiftUI
//
//struct WinnerView: View {
//    var board: Board
//    
//    var body: some View {
//        VStack {
//            Text("Vencedor")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//            CellView(
//                value: board.winner?.player,
//                isWinnerCell: false
//            )
//            .frame(width: 100, height: 100)
//            Button {
//                board.reset()
//            } label: {
//                Text("Resetar o jogo")
//                    .padding(8)
//                    .background(.background)
//                    .clipShape(.capsule)
//                    .foregroundStyle(.primary)
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(
//            ZStack {
//                Color.white.opacity(0.2)
//                BlurView(style: .systemMaterial)
//            }
//        )
//        .ignoresSafeArea()
//    }
//}
//
//#Preview {
//    let board = Board(
//        players: []
//    )
//    board.winner = Winner(player: .X, cells: [1,2,3])
//    
//    return WinnerView(
//        board: board
//    )
//}
