import Foundation
import MapKit
import Firebase
import FirebaseFirestore

class MapViewModel: ObservableObject {
    @Published var houseAnnotations: [IdentifiableAnnotation] = []

    // Fetch house annotations from Firestore
    func fetchHouseAnnotations() {
        let db = Firestore.firestore()
        db.collection("houses").getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self?.houseAnnotations.removeAll()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let latitude = data["latitude"] as? Double ?? 0
                    let longitude = data["longitude"] as? Double ?? 0
                    let price = data["price"] as? Int
                    let phoneNumber = data["phoneNumber"] as? String

                    let annotation = MKPointAnnotation()
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

                    let identifiableAnnotation = IdentifiableAnnotation(annotation: annotation, price: price, phoneNumber: phoneNumber)
                    self?.houseAnnotations.append(identifiableAnnotation)
                }
            }
        }
    }

    // Add a new house annotation to Firestore
    func addHouseToFirebase(_ house: HouseListing) {
        let db = Firestore.firestore()
        var houseData = house.dictionary
        houseData["latitude"] = house.latitude
        houseData["longitude"] = house.longitude
        
        db.collection("houses").addDocument(data: houseData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                let annotation = MKPointAnnotation()
                annotation.title = house.title
                annotation.coordinate = CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)
                let newAnnotation = IdentifiableAnnotation(annotation: annotation, price: house.price, phoneNumber: house.phoneNumber)
                DispatchQueue.main.async {
                    self.houseAnnotations.append(newAnnotation)
                }
            }
        }
    }
}
