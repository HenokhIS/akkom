//
//  BookmarkButton.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 17/04/25.
//

import SwiftUI

struct BookmarkButton: View {
    @EnvironmentObject var store: HouseStore
        let house: House
    
    var body: some View {
            Button(action: {
                store.toggleSaved(for: house)
            }) {
                Image(systemName: store.houses.first(where: { $0.id == house.id })?.isSaved == true ? "bookmark.fill" : "bookmark")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.primary)

                
            }
            .frame(width: 42, height: 42)
            .foregroundColor(Color.primary)
            .background(Color(.systemBackground))
            .cornerRadius(21)
            .shadow(color: Color.primary.opacity(0.4),
                radius: 4)
        }
}

#Preview {
    BookmarkButton(house: (House.dummyHouses[0])).environmentObject(HouseStore())
}
