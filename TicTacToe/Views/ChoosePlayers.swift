//
//  ChoosePlayers.swift
//  TicTacToe
//
//  Created by Lucas Sesti on 24/11/24.
//

import SwiftUI

struct ChoosePlayers: View {
    @State var playerOne: String = ""
    @State var playerTwo: String = ""
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case playerOne
        case playerTwo
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 10)
                
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)

                Spacer()
                    .frame(height: 10)
                
                Text("Tic Tac Toe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .foregroundStyle(Color.ttBlue)
                    
                    TextField(
                        "Player 1",
                        text: $playerOne
                    )
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .playerOne)
                    .onSubmit {
                        focusedField = .playerTwo
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 15))
                
                Spacer().frame(height: 20)
                
                HStack {
                    Image(systemName: "circle")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .foregroundStyle(Color.ttGreen)
                    
                    TextField(
                        "Player 2",
                        text: $playerTwo
                    )
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .playerTwo)
                    .onSubmit {
                        focusedField = nil
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 15))
                
                Spacer()
                    .frame(height: 50)
                
                NavigationLink {
                    BoardView(
                        players: [
                            Player(name: playerOne, symbol: .X),
                            Player(name: playerTwo, symbol: .O)
                        ]
                    )
                } label: {
                    Text("Start game")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .padding(8)
                        .background(.gray.opacity(0.1))
                        .clipShape(Capsule())
                        .foregroundStyle(Color.primary)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Spacer()
                    .frame(height: 10)
            }
            .padding()
        }
    }
}

#Preview {
    ChoosePlayers()
}
