//
//  MediaFile.swift
//  akkom
//
//  Created by Henokh Abhinaya Tjahjadi on 07/04/25.
//

import SwiftUI

// Sample Model and Reels Videos..
struct MediaFile: Identifiable {
    var id: UUID = UUID()
    var url: String
    var title: String
    var description: String
    var price: String
    var location: String
    var distance: String
    var availability: String
    var rating: Double = 0
    var isExpanded: Bool = false
}

//var MediaFileJSON = [
//    
//]

