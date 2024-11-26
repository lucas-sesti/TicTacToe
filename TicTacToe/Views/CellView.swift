//
//  CellView.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 23/11/24.
//

import SwiftUI

struct CellView: View {
    var value: CellValue?
    var isWinnerCell: Bool
    
    var body: some View {
        ZStack {
            createBackground()
                .clipShape(.rect(cornerRadius: 8))
                .animation(.easeInOut, value: value)
            
            if value != nil {
                Image(systemName: value == .X ? "xmark" : "circle")
                    .font(.system(size: 60))
                    .fontWeight(.black)
                    .foregroundStyle(getIconColor())
                    .transition(
                        .scale(
                            scale: 0.5,
                            anchor: .center
                        ).combined(
                            with: .opacity
                        )
                    )
                    .animation(.spring(), value: value)
            }
        }
    }
    
    func createBackground() -> some View {
        if value == .X {
            if isWinnerCell {
                return Color.lightBlue
            }
            
            return Color.ttBlue
        }
        
        if value == .O {
            if isWinnerCell {
                return Color.lightGreen
            }
            
            return Color.ttGreen
        }
        
        return Color.gray.opacity(0.2)
    }
    
    func getIconColor() -> Color {
        if isWinnerCell {
            if value == .X {
                return Color.ttBlue
            }
            
            if value == .O {
                return Color.ttGreen
            }
        }
        
        return .white
    }
}

#Preview {
    CellView(
        value: .X,
        isWinnerCell: true
    )
}
