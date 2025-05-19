//
//  akkomApp.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 07/04/25.
//

import SwiftUI

@main
struct akkomApp: App {
    @StateObject var store = HouseStore()
    var body: some Scene {
        WindowGroup {
                    ContentView()
                        .environmentObject(store)
                }
    }
}

#Preview {
    SavedView()
        .environmentObject(HouseStore())
}
