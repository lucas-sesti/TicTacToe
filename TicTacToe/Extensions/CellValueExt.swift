//
//  Player.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 23/11/24.
//

import Foundation

extension CellValue {
    func getName() -> String {
        switch self {
        case .X:
            return "X"
        case .O:
            return "O"
        }
    }
}
