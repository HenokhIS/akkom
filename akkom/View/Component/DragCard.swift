import SwiftUI

struct DragCard: View {
    @EnvironmentObject var store: HouseStore
    @Binding var house: House
    @Binding var cardOffset: CGFloat
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // MARK: House Info
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(house.name)
                            .font(.title)
                            .bold()
                        Spacer()
                        BookmarkButton(house: house)
                    }
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(house.location)
                    }
                    .foregroundColor(.gray)
                    
                    // MARK: Price
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rp. \(formatPrice(house.price))/month")
                            .font(.title2)
                            .bold()
                        
                        Text("All utilities included")
                            .foregroundColor(.gray)
                    } .padding(.vertical)
                    
                    Divider()
                    
                    // MARK: Description
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Description")
                            .font(.headline)
                        Text(house.description)
                            .foregroundColor(.gray)
                    } .padding(.vertical)
                    
                    Divider()
                    
                    // MARK: Room Facilities
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Room facilities")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], alignment: .leading, spacing: 24) {
                            ForEach(house.amenities) { amenity in
                                Label(amenity.name, systemImage: amenity.icon)
                                
                            }
                        }
                    } .padding(.vertical)
                    
                    Divider()
                    
                    // MARK: Location
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Location")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray5))
                            .frame(height: 200)
                            .overlay(
                                Image(systemName: "map")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(.gray)
                            )
                    } .padding(.vertical)
                    
                    Divider()

                    //MARK: Reach Us
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Reach us")
                            .font(.title3)
                            .fontWeight(.semibold)
                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack(spacing: 12) {
                                if let profileImage = house.owner.profileImage {
                                    Image(profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 50, height: 50)
                                        .overlay(
                                            Image(systemName: "person.fill")
                                                .foregroundColor(.gray)
                                        )
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(house.owner.name)
                                        .font(.headline)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Label("+62 811 2345 6789", systemImage: "phone")
                            Label("user@gmail.com", systemImage: "envelope")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical)
                    
                    Divider()

                    // MARK: Ratings & Reviews
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Ratings & Reviews")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top) {
                            Text("4.5")
                                .font(.system(size: 48, weight: .bold))
                            
                            Spacer()
                            
                            VStack(spacing: 4) {
                                HStack(spacing: 2) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < 4 ? "star.fill" : "star.leadinghalf.filled")
                                            .foregroundColor(Color.primary)
                                    }
                                }
                                Text("2K Ratings")
                                    .font(.subheadline)
                                    .foregroundColor(Color.secondary)
                            }
                        }
                        
                        Text("Most Helpful Reviews")
                            .font(.headline)
                            .padding(.top, 8)
                        
                        VStack(spacing: 16) {
                            ReviewCard(
                                title: "Amazing",
                                rating: 5,
                                user: "User A",
                                timeAgo: "1y ago",
                                comment: "Loving the place so much"
                            )
                            
                            ReviewCard(
                                title: "Perfect Location",
                                rating: 4,
                                user: "User B",
                                timeAgo: "2m ago",
                                comment: "Close to everything that you need"
                            )
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 20)
        }
        .background(Color(.systemBackground))
        .offset(y: max(0, cardOffset + dragOffset))
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    let maxOffset = UIScreen.main.bounds.height * 0.3
                    if value.translation.height > maxOffset {
                        cardOffset = maxOffset
                    } else {
                        cardOffset = 0
                    }
                }
        )
    }
    
    private func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

// MARK: Review Card
struct ReviewCard: View {
    let title: String
    let rating: Int
    let user: String
    let timeAgo: String
    let comment: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(user)
                    .font(.headline)
                Spacer()
                Text("\(rating)")
                Image(systemName: "star.fill")
                    .foregroundColor(Color.primary)
            }
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(timeAgo)
                .font(.subheadline)
                .foregroundColor(Color.secondary)
            
            Text(comment)
                .font(.subheadline)
                .foregroundColor(Color.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        
    }
}

#Preview {
    DragCard(
        house: .constant(House.dummyHouses[0]),
        cardOffset: .constant(0)
        
    ) .environmentObject(HouseStore())
}
