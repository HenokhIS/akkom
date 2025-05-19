import Foundation

struct House: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let location: String
    let description: String
    let price: Int
    let rating: Double
    let distance: Double
    let availableRooms: Int
    let images: [String]
    var isSaved: Bool
    let amenities: [Amenity]
    let owner: Owner
    
    static func toggleSaved(for house: House) {
        if let index = House.dummyHouses.firstIndex(where: { $0.id == house.id }) {
            House.dummyHouses[index].isSaved.toggle()
        }
    }
}

struct Amenity: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let icon: String
}

struct Owner: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let profileImage: String?
}

// Dummy Data
extension House {
    func recommendationScore(maxPrice: Double, maxDistance: Double) -> Double {
            let normalizedPrice = 1 - min(Double(price) / maxPrice, 1)
            let normalizedDistance = 1 - min(distance / maxDistance, 1)
            let normalizedRating = rating / 5.0 // because max rating is 5
            
            // Weighting factors (can be adjusted)
            let priceWeight = 0.3
            let distanceWeight = 0.3
            let ratingWeight = 0.4
            
            return (normalizedPrice * priceWeight) +
                   (normalizedDistance * distanceWeight) +
                   (normalizedRating * ratingWeight)
        }
    
    static var dummyHouses: [House] = [
        House(
            name: "Modern Beach Villa",
            location: "Kuta, Bali",
            description: "Beautiful villa with ocean view, perfect for long-term stay",
            price: 6000000,
            rating: 4.3,
            distance: 2.8,
            availableRooms: 3,
            images: ["house1_1", "house1_2", "house1_3"],
            isSaved: true,
            amenities: [
                Amenity(name: "WiFi", icon: "wifi"),
                Amenity(name: "Air Conditioning", icon: "air.conditioner.horizontal"),
                Amenity(name: "Swimming Pool", icon: "figure.pool.swim"),
                Amenity(name: "Parking", icon: "car.fill")
            ],
            owner: Owner(
                name: "John Doe",
                profileImage: "owner1"
            )
        ),
        House(
            name: "Cozy Studio Apartment",
            location: "Seminyak, Bali",
            description: "Modern studio apartment in the heart of Seminyak",
            price: 4500000,
            rating: 4.5,
            distance: 1.5,
            availableRooms: 1,
            images: ["house2_1", "house2_2", "house2_3"],
            isSaved: false,
            amenities: [
                Amenity(name: "WiFi", icon: "wifi"),
                Amenity(name: "Air Conditioning", icon: "air.conditioner.horizontal"),
                Amenity(name: "Kitchen", icon: "fork.knife"),
                Amenity(name: "Laundry", icon: "washer.fill")
            ],
            owner: Owner(
                name: "Jane Smith",
                profileImage: "owner2"
            )
        ),
        House(
            name: "Luxury Penthouse",
            location: "Canggu, Bali",
            description: "Spacious penthouse with panoramic views",
            price: 8000000,
            rating: 4.7,
            distance: 3.2,
            availableRooms: 2,
            images: ["house3_1", "house3_2", "house3_3", "house3_4"],
            isSaved: false,
            amenities: [
                Amenity(name: "WiFi", icon: "wifi"),
                Amenity(name: "Air Conditioning", icon: "air.conditioner.horizontal"),
                Amenity(name: "Gym", icon: "figure.run"),
                Amenity(name: "Rooftop Pool", icon: "figure.pool.swim")
            ],
            owner: Owner(
                name: "Mike Johnson",
                profileImage: "owner3"
            )
        )
    ]
} 
