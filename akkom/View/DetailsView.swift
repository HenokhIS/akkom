import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var store: HouseStore
    @Environment(\.dismiss) var dismiss
    @State var house: House
    @State private var currentIndex: Int = 0
    @State private var cardOffset: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Carousel with Bookmark Button
            ZStack(alignment: .topTrailing) {
                TabView(selection: $currentIndex) {
                    ForEach(Array(house.images.enumerated()), id: \.offset) { index, image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 250)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
            }
            
            // DragCard Container
            GeometryReader { geometry in
                DragCard(house: $house, cardOffset: $cardOffset)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    NavigationView {
        DetailsView(house: House.dummyHouses[0])
            .environmentObject(HouseStore())
    }
} 
