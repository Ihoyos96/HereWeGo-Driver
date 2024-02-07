import Foundation

class WebSocketManager: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: "ws://172.20.10.8:3000")!
    private var isConnected: Bool = false
    
    @Published var tripRequest: Trip?

    func connect() {
        guard !isConnected else { return }

        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
        isConnected = true

        // Call identifyAsDriver right after establishing the connection
        identifyAsDriver()
    }

    func disconnect() {
        guard isConnected else { return }

        webSocketTask?.cancel(with: .goingAway, reason: nil)
        isConnected = false
    }
    
    private func identifyAsDriver() {
        // Assuming driver's availability is true by default when they connect
        // Modify as needed, perhaps based on some app state or user input
        let identificationMessage = ["type": "identify", "role": "driver", "isAvailable": true] as [String : Any]
        guard let messageData = try? JSONSerialization.data(withJSONObject: identificationMessage, options: []),
              let messageString = String(data: messageData, encoding: .utf8) else {
            print("Error: Unable to serialize identification message to JSON string")
            return
        }

        sendMessage(messageString)
    }

    // When accepting a trip
    func acceptTrip(tripId: String) {
        let acceptMessage = [
            "type": "acceptTrip",
            "tripId": tripId, 
            "driverId": "YOUR_DRIVER_ID"
        ]
        guard let messageData = try? JSONSerialization.data(withJSONObject: acceptMessage, options: []),
              let messageString = String(data: messageData, encoding: .utf8) else {
            print("Error: Unable to serialize identification message to JSON string")
            return
        }
        
        sendMessage(messageString)
    }
    
    func declineTrip(tripId: String, driverId: String) {
        let declineMessage = [
            "type": "declineTrip",
            "tripId": tripId,
            "driverId": driverId
        ]
        guard let messageData = try? JSONSerialization.data(withJSONObject: declineMessage, options: []),
              let messageString = String(data: messageData, encoding: .utf8) else {
            print("Error: Unable to serialize decline trip message to JSON string")
            return
        }

        sendMessage(messageString)
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let dataString):
                    print("Received string: \(dataString)")
                    self?.processReceivedString(dataString)
                case .data(let data):
                    print("Received data: \(data)")
                default:
                    break
                }

                self?.receiveMessage()
            }
        }
    }

    func sendMessage(_ message: String) {
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print("Error in sending message: \(error)")
            }
        }
    }
    
    private func processReceivedString(_ text: String) {
        // Attempt to decode the JSON string into a Trip object
        if let data = text.data(using: .utf8) {
            do {
                let tripWrapper = try JSONDecoder().decode(TripDataWrapper.self, from: data)
                print("Received trip: \(tripWrapper.data)")
                DispatchQueue.main.async {
                    self.tripRequest = tripWrapper.data
                }
            } catch {
                print("Error decoding trip data: \(error)")
            }
        }
    }
}

