

import SwiftUI
import Firebase
import FirebaseFirestore
import CoreLocation


struct HouseInputForm: View {
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var address: String = ""
    @State private var price: String = ""
    @State private var phoneNumber: String = "" // State for phone number
    var onHouseAdded: (HouseListing) -> Void
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .textFieldStyle(DefaultTextFieldStyle())
            TextField("Address", text: $address)
                .textFieldStyle(DefaultTextFieldStyle())
            TextField("Price Per Month", text: $price)
                .textFieldStyle(DefaultTextFieldStyle())
                .keyboardType(.numberPad)
            TextField("Phone Number", text: $phoneNumber) // New text field for phone number
                .textFieldStyle(DefaultTextFieldStyle())
                .keyboardType(.phonePad)

            Button("Submit") {
                submitHouseDetails()
                isPresented = false
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(12)
        }
        .padding()
    }
    
    func submitHouseDetails() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                // Handle the error (e.g., address not found)
                return
            }

            let house = HouseListing(
                title: self.title,
                address: self.address,
                price: Int(self.price) ?? 0,
                phoneNumber: self.phoneNumber ,  // Use `number` as the phone number
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            self.addHouseToFirebase(house)
        }
    }


    func addHouseToFirebase(_ house: HouseListing) {
        let db = Firestore.firestore()
        var houseData = house.dictionary
        houseData["latitude"] = house.latitude
        houseData["longitude"] = house.longitude
        
        db.collection("houses").addDocument(data: houseData) { error in
            if let error = error {
                // Handle the error
                print("Error adding document: \(error)")
            } else {
                // Call the closure after successfully adding to Firebase
                self.onHouseAdded(house)
            }
        }
    }
}
