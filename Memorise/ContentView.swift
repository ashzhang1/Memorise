//
//  ContentView.swift
//  Memorise
//
//  Created by Ashley Zhang on 25/11/2024.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis = ["👻", "🎃", "👿", "💀", "🕷️"]
    let vehicleEmojis = ["🚗", "🚕", "🚌", "🚓", "🚑"]
    let sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾"]
    
    let halloweenColor = Color.orange
    let vehicleColor = Color.yellow
    let sportColor = Color.green
    
    //Default to halloween set of emojis
    @State private var emojis = ["👻", "🎃", "👿", "💀", "🕷️", "👻", "🎃", "👿", "💀", "🕷️"]
    @State private var selectedTheme = "Halloween"
    @State private var selectedColor = Color.orange
    @State private var faceUpCardIndices: [Bool] = Array(repeating: false, count: 10)
    
    var body: some View {
        Text("Memorise!")
            .font(.largeTitle)
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 95))]) {
            
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(
                    content: emojis[index],
                    isFaceUp: faceUpCardIndices[index],
                    onTap: { faceUpCardIndices[index].toggle() }
                )
                .aspectRatio(1, contentMode: .fit)
            }
        }
        .foregroundStyle(selectedColor)
    }
    
    var themeButtons: some View {
        HStack(spacing: 50) {
            themeButton(name: "Halloween", icon: "theatermasks", emojiArr: halloweenEmojis, color: halloweenColor)
            themeButton(name: "Vehicles", icon: "car.rear", emojiArr: vehicleEmojis, color: vehicleColor)
            themeButton(name: "Sports", icon: "basketball", emojiArr: sportEmojis, color: sportColor)
        }
    }
    
    func themeButton(name: String, icon: String, emojiArr: [String], color: Color) -> some View {
        VStack {
            Button(action: {
                emojis = (emojiArr + emojiArr).shuffled()
                selectedTheme = name
                faceUpCardIndices = Array(repeating: false, count: 10)
                selectedColor = color
            }, label: {
                Image(systemName: icon)
                    .font(.title)
            })
            Text(name)
                .font(.subheadline)
        }
        .foregroundColor(selectedTheme == name ? .red : .blue)
    }
}


struct CardView: View {
    let content: String
    let isFaceUp: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    ContentView()
}
