//
//  TripRequestsView.swift
//  HereWeGoDriver
//
//  Created by Ian Hoyos on 1/31/24.
//

import SwiftUI

struct TripRequestsView: View {
    @ObservedObject var webSocketManager = WebSocketManager()
    
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            Spacer() // ----------
            
            VStack (alignment: .leading, spacing: 0){
                HStack {
                    Text("Trip ID:\t")
                    Text(webSocketManager.tripRequest?.tripId ?? "")
                }
                
                HStack {
                    Text("User ID:")
                    Text(webSocketManager.tripRequest?.userId ?? "")
                }
                
                HStack {
                    Text("Pickup Location:\t")
                    Text(webSocketManager.tripRequest?.pickupLocation ?? "")
                }
                
                HStack {
                    Text("Dropoff Location:\t")
                    Text(webSocketManager.tripRequest?.dropoffLocation ?? "")
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.indigo, lineWidth: 2)
                    .fill(Color.clear)
            )
            
            Spacer()
            
            HStack {
                Button {
                    webSocketManager.acceptTrip(tripId: webSocketManager.tripRequest?.tripId ?? "")
                } label: {
                    Text("Accept")
                        .font(.custom("Helvetica Neue", size: 20))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 15)
                        .frame(width: screenWidth/3)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .stroke(Color.green, lineWidth: 2)
                                .fill(Color.green)
                        )
                }
                
                Button {
                    
                    
                } label: {
                    Text("Decline")
                        .font(.custom("Helvetica Neue", size: 20))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 15)
                        .frame(width: screenWidth/3)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .stroke(Color.red, lineWidth: 2)
                                .fill(Color.red)
                        )
                }
            }
            
            Spacer() // ----------
        }
        .onAppear {
            // Connect
            webSocketManager.connect()
        }
    }
}

struct TripRequestView_Preview: PreviewProvider {
    static var previews: some View {
        TripRequestsView()
    }
}
