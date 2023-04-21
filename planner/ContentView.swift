//
//  ContentView.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
                .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
