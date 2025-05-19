//
//  ReelsView.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 11/04/25.
//

import SwiftUI

struct ReelsView: View {
    let house: House
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                Image(house.images.first ?? "previewimage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.8), Color.black.opacity(0.4), Color.black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: geometry.size.width * 0.6)
                .frame(maxWidth: .infinity)
//                .background(.ultraThinMaterial)
//                .cornerRadius(20)
//                .offset(y: 40)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(house.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        VStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                            Text(String(format: "%.1f", house.rating))
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }

                    Text(house.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))

                    VStack(alignment: .leading, spacing: 4) {
                        Label("Rp. \(formatPrice(house.price))/month", systemImage: "creditcard")
                        Label(house.location, systemImage: "mappin.and.ellipse")
                        Label(String(format: "%.1f km away", house.distance), systemImage: "location")
                        Label("\(house.availableRooms) room\(house.availableRooms > 1 ? "s" : "") available", systemImage: "bed.double.fill")
                    }
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
                }
                .padding()
            }
        }
//        .cornerRadius(20)
    }
    
    private func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

#Preview {
    ReelsView(house: House.dummyHouses[0]).environmentObject(HouseStore())
}
