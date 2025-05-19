//
//  HouseStore.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 18/04/25.
//

import SwiftUI

class HouseStore: ObservableObject {
    @Published var houses: [House] = House.dummyHouses

    func toggleSaved(for house: House) {
        if let index = houses.firstIndex(where: { $0.id == house.id }) {
            houses[index].isSaved.toggle()
        }
    }

    var savedHouses: [House] {
        houses.filter { $0.isSaved }
    }
}

