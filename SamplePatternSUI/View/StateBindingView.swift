//
//  StateBindingView.swift
//  SamplePatternSUI
//
//  Created by Jazilul Athoya on 13/08/21.
//

import SwiftUI

struct StateView: View {
  @State var intValue = 0

  var body: some View {
      Button("Increment") {
        intValue += 1
        print(intValue)
      }
  }
}

struct BindingView: View {
  @Binding var intValue: Int

  var body: some View {
    Button("Increment") {
        intValue += 1
        print(intValue)
    }
  }
}

struct StateBindingView: View {
    @State private var intValue = 0
    
    var body: some View {
        VStack {
          Text("intValue equals \(intValue)")

          BindingView(intValue: $intValue)
        }
    }
}

struct StateBindingView_Previews: PreviewProvider {
    static var previews: some View {
        StateBindingView()
    }
}
