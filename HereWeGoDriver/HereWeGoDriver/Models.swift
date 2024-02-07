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

struct TripDataWrapper: Codable {
    var type: String
    var data: Trip
}

struct IdentificationMessage: Codable {
    var type: String
    var role: String
    var isAvailable: Bool
    
    init(type: String, role: String, isAvailable: Bool) {
        self.type = type
        self.role = role
        self.isAvailable = isAvailable
    }
}

struct AcceptanceMessage: Codable {
    var type: String
    var tripId: String
    var driverId: String
    
    init (type: String, tripId: String, driverId: String) {
        self.type = type
        self.tripId = tripId
        self.driverId = driverId
    }
}
