//
//  ContentView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 20/01/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(GreetingBuilder.greeting(name: "world"))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
