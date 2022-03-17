//
//  ContentView.swift
//  TypewriterTextEffect
//
//  Created by Глеб Михновец on 02.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State var lettersShowing: Double = 0
    let textToShow: String = "Hello, it's a me, Mario! I have a pizza!"
    
    var body: some View {
        VStack {
            AppearingText(
                fullText: textToShow,
                numberOfLettersShow: lettersShowing,
                font: .title
            )
            .fixedSize()
            .animation(.linear(duration: 2.0), value: lettersShowing)

            Button("Activate") {
                lettersShowing += Double(textToShow.count)
            }
            .padding()
            
            Button("Reset") {
                lettersShowing = 0
            }
            .padding()
            
        }
        .frame(width: 500, height: 300)
    }
}


struct AppearingText: View, Animatable {
    var fullText: String
    var numberOfLettersShow: Double
    var font: Font
    
    var animatableData: Double {
           get { numberOfLettersShow }
           set { numberOfLettersShow = newValue }
       }
    
    var numberOfLettersShowing: Int {
        get {
            Int(numberOfLettersShow) <= fullText.count ?
                Int(numberOfLettersShow) : fullText.count
            
        }
    }
    
    var numberOfLettersDropped: Int {
        get { fullText.count - numberOfLettersShowing }
    }
    
    var portionOfText: Substring {
        get { fullText.dropLast(numberOfLettersDropped) }
    }
    
 
    
    var body: some View {
        Text(
            Int(numberOfLettersShow) > fullText.count ?
             portionOfText : portionOfText.dropLast()).font(font
             )
        + Text(
            portionOfText.dropFirst(
            Int(numberOfLettersShow) > fullText.count ?
                numberOfLettersShowing:
                numberOfLettersShowing - 1 < 0 ?
                    numberOfLettersShowing :
                    numberOfLettersShowing - 1
                )
            )
            .font(font)
            .bold()
            .baselineOffset(numberOfLettersShowing % 2 == 0 ? -1 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
