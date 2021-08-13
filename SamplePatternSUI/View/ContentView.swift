//
//  ContentView.swift
//  SamplePatternSUI
//
//  Created by Jazilul Athoya on 06/08/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: LocationViewModel = LocationViewModel()
    
    var body: some View {
//        if let s = viewModel.currentLocation?.coordinate.latitude {
//            Text("latitude = \(s)")
//        }
        Text("Current Location: \(viewModel.currentLocation?.coordinate.latitude ?? 0)")
        Button("Get Location") {
            viewModel.getLocation()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
