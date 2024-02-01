import Foundation

class WebSocketClient {
    private var webSocketTask: URLSessionWebSocketTask?
    private var url: URL
    private var isConnected: Bool = false

    init(url: URL) {
        self.url = url
    }

    func connect() {
        guard !isConnected else { return }

        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
        isConnected = true
    }

    func disconnect() {
        guard isConnected else { return }

        webSocketTask?.cancel(with: .goingAway, reason: nil)
        isConnected = false
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received string: \(text)")
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
}
