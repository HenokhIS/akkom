//
//  SavedView.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 07/04/25.
//

import SwiftUI

struct SavedView: View {
    @State private var searchText = ""
    @EnvironmentObject var store: HouseStore
    var savedHouses: [House] {
        store.savedHouses
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                Text("Saved")
                    .font(.system(size: 32, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                // Search Bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                // Saved Houses Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(savedHouses) { house in
                            SavedHouseCard(house: house)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SavedHouseCard: View {
    let house: House
    
    var body: some View {
        NavigationLink(destination: DetailsView(house: house)) {
            VStack(alignment: .leading, spacing: 8) {
                if let imageName = house.images.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 120)
                        .cornerRadius(10)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                        )
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(house.name)
                            .font(.headline)
                        Spacer()
                        Text(String(format: "%.1f", house.rating))
                        Image(systemName: "star.fill")
                            .font(.caption)
                    }
                    
                    Text(house.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("\(house.availableRooms) room\(house.availableRooms > 1 ? "s" : "") available")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SavedView()
        .environmentObject(HouseStore())
}
