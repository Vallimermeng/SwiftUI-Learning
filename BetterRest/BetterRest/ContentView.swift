//
//  ContentView.swift
//  BetterRest
//
//  Created by Петя on 12.08.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...24, step: 0.25)
    }
}

#Preview {
    ContentView()
}
