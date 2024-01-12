import SwiftUI
import FirebaseFirestore

struct HouseFormPopup: View {
    @Binding var isPresented: Bool
    @State private var title = ""
    @State private var address = ""
    @State private var price = 0.0

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Address", text: $address)
                    TextField("Price", value: $price, formatter: NumberFormatter())
                }
            }

            Button("Submit") {
                // Add logic to submit the information to the database
                submitToDatabase()
                // Close the popup
                isPresented = false
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }

    func submitToDatabase() {
        let newHouse = HouseListing(title: title, address: address, price: price)
        let db = Firestore.firestore()
        
        do {
            let _ = try db.collection("houses").addDocument(from: newHouse)
        } catch {
            print("Error adding document: \(error)")
        }
    }
}
