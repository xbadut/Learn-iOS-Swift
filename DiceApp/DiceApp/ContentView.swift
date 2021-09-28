//
//  ContentView.swift
//  DiceApp
//
//  Created by Rizal Fahrudin on 28/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var leftDice = 1
    @State var rightDice = 2

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(num: leftDice)
                    DiceView(num: rightDice)
                }
                Spacer()
                Button(
                    action: {
                        self.leftDice = Int.random(in: 1...6)
                        self.rightDice = Int.random(in: 1...6)
                    }
                ){
                    Text("Roll")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .frame(height: 50, alignment: .center)
                .background(Color.red)
            }
        }
    }
}

struct DiceView: View {
    let num: Int
    
    var body: some View {
        Image("dice\(num)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
