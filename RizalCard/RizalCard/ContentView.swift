//
//  ContentView.swift
//  RizalCard
//
//  Created by Rizal Fahrudin on 27/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(UIColor.cyan)
                .ignoresSafeArea()
            
            VStack {
                Image("rizal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Text("Rizal Fahrudin")
                    .font(.system(size: 40))
                    .bold()
                RoundedRectangle(
                    cornerRadius: 25)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .overlay(
                        HStack {
                            Text("N0.")
                                .foregroundColor(.green)
                            Text("082161616262")
                                .foregroundColor(.white)
                        }
                    )
                    .frame(height: 50)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
