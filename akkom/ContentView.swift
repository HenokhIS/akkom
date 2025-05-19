//
//  ContentView.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 07/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NearMe()
            .environmentObject(HouseStore())
    }
}

#Preview {
    ContentView()
}
