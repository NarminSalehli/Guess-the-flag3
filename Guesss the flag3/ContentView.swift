//
//  ContentView.swift
//  Guesss the flag3
//
//  Created by Nərmin Salehli on 22.06.26.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingAlert = false
    @State private var userScore = 0
    @State private var questionCount = 1
    @State private var showingFinalAlert = false
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "True"
            userScore += 1
            
        } else {
            scoreTitle = "Wrong, this flag is belong to \(countries[number])"
        }
        showingAlert = true
    }
    
    func askQuestion() {
        if questionCount == 8 {
            showingFinalAlert = true
        } else {
            questionCount += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func resetGame() {
        userScore = 0
        questionCount = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                    Text("Question \(questionCount) of 8")
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                    
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
                Text("Result \(userScore)")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .bold()
            }
        }
        .alert(scoreTitle, isPresented: $showingAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        
        .alert(scoreTitle, isPresented: $showingFinalAlert) {
            Button("Restart game", action: resetGame)
        } message: {
            Text("You finished the game, Your score is \(userScore) out of 8")
        }
    }
    
}

#Preview {
    ContentView()
}
