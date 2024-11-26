//
//  TimerView.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 24/11/24.
//

import SwiftUI

struct TimerView: View {
    @Binding var board: Board
    
    var onPause: () -> Void
    
    var body: some View {
        ZStack {
            Capsule()
                .stroke(Color.gray.opacity(0.2), lineWidth: 4)
                .frame(width: 95, height: 40)
            
            Capsule()
                .trim(from: 0, to: board.progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(180))
                .frame(width: 95, height: 40)
            
            HStack(spacing: 8) {
                Text("\(board.timeRemaining) sec")
                    .font(.system(size: 14, weight: .bold))
                    
                Button(action: {
                    onPause()
                }) {
                    Image(systemName: board.isPaused ? "play.circle" : "pause.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                }
            }
            .padding(8)
            .frame(width: 90, height: 37)
            .background(.gray.opacity(0.1))
            .clipShape(Capsule())
            .foregroundStyle(.primary)
        }
    }
}

//#Preview {
//    TimerView(
//        onTimerFinish: {
//            
//        }
//    )
//}
