//
//  NearMe.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 07/04/25.
//

import SwiftUI

struct NearMe: View {
    @State private var scrollID: UUID = UUID()
    @State private var searchText: String = ""
    @State private var scrollOffset: CGFloat = 0
    let houses = House.dummyHouses
        .sorted {
            $0.recommendationScore(
                maxPrice: House.dummyHouses.map { Double($0.price) }.max() ?? 1,
                maxDistance: House.dummyHouses.map { $0.distance }.max() ?? 1
            ) > $1.recommendationScore(
                maxPrice: House.dummyHouses.map { Double($0.price) }.max() ?? 1,
                maxDistance: House.dummyHouses.map { $0.distance }.max() ?? 1
            )
        }

    
    var body: some View {
        NavigationView {
            TabView {
                VStack(spacing: 0) {
                    // Search Bar
//                VStack(alignment: .leading, spacing: 0) {
//                    HStack {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                            TextField("Search", text: $searchText)
//                        }
//                        .padding(10)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom, 10)
//                }
//                .background(Color.white)
                    
                    // MARK: Scrollable Reels
                    GeometryReader { geometry in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 40) {
                                ForEach(Array(repeating: houses, count: 3).flatMap { $0 }.enumerated().map { $0 }, id: \.1.id) { index, house in
                                    NavigationLink(destination: DetailsView(house: house)) {
                                        ZStack(alignment: .topLeading) {
                                            ReelsView(house: house)
                                                .onAppear {
                                                    if index == houses.count * 3 - 1 {
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                            scrollID = UUID()
                                                        }
                                                    }
                                                }
                                                .frame(
                                                    width: geometry.size.width,
                                                    height: geometry.size.height
                                                )
                                                .shadow(radius: 5)
                                            
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.black.opacity(0), Color.black.opacity(0.2), Color.black.opacity(0.4)]),
                                                startPoint: .bottom,
                                                endPoint: .top
                                            )
                                            .frame(height: geometry.size.width * 0.4)
                                            .frame(maxWidth: .infinity)
                                            
                                            if house.id == houses.first?.id {
                                                Text("Near Me")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                    .padding(.leading, 20)
                                                    .padding(.top, 60)
                                            }
                                        }
                                        
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }.ignoresSafeArea()
                        }
                        .id(scrollID)
                        .scrollTargetBehavior(.paging)
                    }
                }
                .ignoresSafeArea(.container, edges: .top)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Near Me")
                }
                
                SavedView()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Saved")
                    }
            }
        }
    }
}

#Preview {
    NearMe()
        .environmentObject(HouseStore())
}

