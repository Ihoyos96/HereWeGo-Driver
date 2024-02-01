//
//  Models.swift
//  HereWeGoDriver
//
//  Created by Ian Hoyos on 1/31/24.
//

import Foundation

struct Trip: Codable, Identifiable {
    var id: String { tripId }
    var tripId: String
    var userId: String
    var pickupLocation: String
    var dropoffLocation: String
    var tripStatus: String
    // Add other properties as needed
}
