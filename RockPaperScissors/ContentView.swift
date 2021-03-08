//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Marjo Salo on 02/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rockPaperScissors = ["👊", "✋", "✌️"].shuffled()
    @State private var randomIndex = Int.random(in: 0...2)
    @State private var selectedIndex = 0
    @State var shouldWin = Bool.random()
    @State private var answer = ""
    @State private var counter = 0
    @State private var score = 0
    
    var randomIcon: String { rockPaperScissors[randomIndex] }
    var selectedIcon: String { rockPaperScissors[selectedIndex] }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.6470588235, green: 0.9490196078, blue: 0.9529411765, alpha: 0.7548846314)), Color.init(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 50) {
                if counter < 10 {
                    
                    Text(randomIcon)
                        .font(.system(size: 60))
                    
                    HStack {
                        Text("Tap to")
                        Text("\(shouldWin ? "WIN" : "LOSE")")
                            .foregroundColor(shouldWin ? Color.init(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)) : Color.init(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)))
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 22))
                    
                    HStack(spacing: 30) {
                        ForEach(0..<3) { number in
                            Button(action: {
                                selectedIndex = number
                                buttonTapped()
                            }) {
                                Text(self.rockPaperScissors[number])
                                    .font(.system(size: 60))
                            }
                        }
                    }
                    HStack(spacing: 40) {
                        HStack {
                            Text("Round:")
                            Text("\(counter + 1)/10")
                        }
                        HStack {
                            Text("Score:")
                            Text("\(score)")
                                .foregroundColor(score < 0 ? .red : .black)
                        }
                    }
                    .font(.system(size: 16))
                }
            }
                
            VStack(spacing: 40) {
                if counter == 10 {
                    Text("Game Over!")
                        .foregroundColor(Color.init(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    Text("Your score is:")
                        .font(.system(size: 22))
                    Text("\(score)")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Button(action: {
                        counter = 0
                        score = 0
                    }) {
                        Text("Play Again?")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                    }
                    .frame(width: 230.0, height: 55.0)
                    .shadow(radius: 5)
                    .background(Color.blue)
                    .cornerRadius(25.0)
                }
            }
        }
    }
    
    func getAnswer() {
        let winOrLose = (selectedIcon, randomIcon)

        switch winOrLose {
        case ("👊", "✌️"), ("✋", "👊"), ("✌️", "✋"):
            answer = "win"
        case ("👊", "👊"), ("✋", "✋"), ("✌️", "✌️"):
            answer = "draw"
        case ("👊", "✋"), ("✋", "✌️"), ("✌️", "👊"):
            answer = "lose"
        default:
            answer = "draw"
        }
    }
    
    func getScore() {
        if shouldWin == true && answer == "win" || shouldWin == false && answer == "lose" {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func buttonTapped() {
        counter += 1
        getAnswer()
        getScore()
        
        rockPaperScissors.shuffle()
        randomIndex = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
