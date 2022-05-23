

import Foundation
import UIKit

// MARK: - Delivery
struct Delivery: Codable {
    let id, remarks: String
    let pickupTime: String
    let goodsPicture: String
    let deliveryFee, surcharge: String
    let route: Route
    let sender: Sender
}

// MARK: - Route
struct Route: Codable {
    let start, end: String
}

// MARK: - Sender
struct Sender: Codable {
    let phone, name, email: String
}

// MARK: - APIError
enum NetworkError: Error {
    case badURL
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case typeMismatch
    case unknown
}
