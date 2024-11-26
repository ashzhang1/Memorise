//
//  ContentView.swift
//  Memorise
//
//  Created by Ashley Zhang on 25/11/2024.
//

import SwiftUI

struct ContentView: View {
    static let halloweenEmojis = ["👻", "🎃", "👿", "💀", "🕷️"]
    static let vehicleEmojis = ["🚗", "🚕", "🚌", "🚓", "🚑"]
    static let sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾"]
    
    
    @State private var emojis = halloweenEmojis + halloweenEmojis
    @State private var selectedTheme = "Halloween"
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
        .foregroundStyle(.red)
    }
    
    var themeButtons: some View {
        HStack(spacing: 50) {
            themeButton(name: "Halloween", icon: "theatermasks", emojiArr: ContentView.halloweenEmojis)
            themeButton(name: "Vehicles", icon: "car.rear", emojiArr: ContentView.vehicleEmojis)
            themeButton(name: "Sports", icon: "basketball", emojiArr: ContentView.sportEmojis)
        }
    }
    
    func themeButton(name: String, icon: String, emojiArr: [String]) -> some View {
        VStack {
            Button(action: {
                emojis = (emojiArr + emojiArr).shuffled()
                selectedTheme = name
                faceUpCardIndices = Array(repeating: false, count: 10)
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
