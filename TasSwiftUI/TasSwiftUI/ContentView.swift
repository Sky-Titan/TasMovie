//
//  ContentView.swift
//  TasSwiftUI
//
//  Created by 박준현 on 2021/12/08.
//

import SwiftUI

struct ContentView: View {
    @State var buttonText: String = "car"
    
    var body: some View {
        Image(systemName: buttonText)
            .onAppear(perform: {
                print("Appear")
            })
            .onDisappear(perform: {
                print("Disappear")
            })
        Button("변경") {
            press()
        }
    }
    
    func press() {
        buttonText = "car.fill"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
