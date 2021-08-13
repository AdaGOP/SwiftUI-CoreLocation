//
//  EnvironmentContentView.swift
//  SamplePatternSUI
//
//  Created by Jazilul Athoya on 13/08/21.
//

import SwiftUI

// Our observable object class
class GameSettings: ObservableObject {
    @Published var score = 0
}

// A view that expects to find a GameSettings object
// in the environment, and shows its score.
struct ScoreView: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        Text("Score: \(settings.score)")
    }
}

// A view that creates the GameSettings object,
// and places it into the environment for the
// navigation view.
struct EnvironmentContentView: View {
    @StateObject var settings = GameSettings()

    var body: some View {
        NavigationView {
            VStack {
                // A button that writes to the environment settings
                Button("Increase Score") {
                    settings.score += 1
                }

                NavigationLink(destination: ScoreView()) {
                    Text("Show Detail View")
                }
            }
            .frame(height: 200)
        }
        .environmentObject(settings)
    }
}

struct EnvironmentContentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentContentView()
    }
}
