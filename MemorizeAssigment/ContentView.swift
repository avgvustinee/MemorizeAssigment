//
//  ContentView.swift
//  MemorizeAssigment
//
//  Created by DiannaChapter on 2024/06/10.
//

import SwiftUI

struct Theme {
    var name:String
    var emojis:[String]
    var sfSymbolName:String
}

let themes = [
    Theme(name: "Vehicle", emojis: ["🚂","🚑","🚌","🚲","🚓","🚗", "🚎", "🏎", "🚓"], sfSymbolName:"car"),
    Theme(name: "Animals", emojis: ["🐶", "🐱", "🦊", "🐻", "🐼","🦊", "🐻", "🐼", "🐨"], sfSymbolName: "pawprint"),
    Theme(name: "Fruits", emojis: ["🍎", "🍊", "🍋", "🍉", "🍇", "🍓","🍒", "🍑", "🍍", "🥭"], sfSymbolName: "leaf")
]

struct ContentView: View {
    @State private var selectedTheme: Theme = themes[0]
    @State private var emojis: [String] = []
    @State private var shuffledEmojis: [String] = []
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView{
                cardGrid
            }
            cardThemes
        }
        .padding()
        .onAppear{
            selectTheme(selectedTheme)
        }
    }
    
    var cardGrid:some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
            ForEach(0..<shuffledEmojis.count,id: \.self){ index in
                CardView(content: shuffledEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundColor(.red)
    }
    
    
    var cardThemes:some View{
        HStack{
            ForEach(themes, id: \.name){ theme in
                Button(action:{
                    selectTheme(theme)
                } , label:{
                    VStack{
                        Image(systemName: theme.sfSymbolName)
                            .imageScale(.large)
                            .font(.largeTitle)
                        Text(theme.name)
                            .font(.caption)
                    }
                    
                } )
                Spacer()
            }
        }
        .padding()
    }
    
    func selectTheme(_ theme:Theme){
        selectedTheme = theme
        emojis = theme.emojis
        shuffledEmojis = (emojis + emojis).shuffled()
    }
  
}

struct CardView:View{
    let content:String
    
    @State private var isFuceUp = false
    
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text (content).font(.largeTitle)
            }
            .opacity(isFuceUp ? 1 : 0)
            base.fill().opacity(isFuceUp ? 0: 1)
        }
        .onTapGesture {
            isFuceUp.toggle()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
