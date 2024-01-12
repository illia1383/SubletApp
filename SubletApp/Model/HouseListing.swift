



import Foundation

struct HouseListing {
    var title: String
    var address: String
    var price: Int
    var phoneNumber: String // New phone number field
    var latitude: Double
    var longitude: Double

    var dictionary: [String: Any] {
        return [
            "title": title,
            "address": address,
            "price": price,
            "phoneNumber": phoneNumber, // Include in dictionary
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}
