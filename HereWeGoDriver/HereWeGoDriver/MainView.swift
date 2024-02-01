//
//  ContentView.swift
//  HereWeGoDriver
//
//  Created by Ian Hoyos on 1/31/24.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    @State private var isAuthenticated = true

    var body: some View {
        if isAuthenticated {
            VStack {
                ZStack {
                    HStack {
                        Image(systemName: "hare.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(Color.indigo)
                            .offset(x: -90)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("HereWeGo")
                            .font(.custom("Helvetica Neue", size: 24))
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                }
                
                VStack {
                    TripRequestsView()
                }.padding([.top], 100)
                
                Spacer()
            }
        } else {
            // Implement Authentication
//            DriverLoginView()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct MainViewPreview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
