//
//  TripRequestsView.swift
//  HereWeGoDriver
//
//  Created by Ian Hoyos on 1/31/24.
//

import SwiftUI

struct TripRequestsView: View {
    let webSocketClient = WebSocketClient(url: URL(string: "ws://localhost:3000")!)

    var body: some View {
        VStack {
            Text("Hello")
//            if let trip = webSocketManager.incomingTripRequest {
//                Text("New Trip Request")
//                Text("From: \(trip.pickupLocation)")
//                Text("To: \(trip.dropoffLocation)")
//                
//                Button("Accept") {
//                    webSocketManager.sendResponse(for: trip, accepted: true)
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//
//                Button("Reject") {
//                    webSocketManager.sendResponse(for: trip, accepted: false)
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//            } else {
//                Text("Waiting for trip requests...")
//            }
        }
        .onAppear {
            

            // Connect
            webSocketClient.connect()
            webSocketClient.sendMessage("Hello WebSocket Server!")
        }
    }
}
