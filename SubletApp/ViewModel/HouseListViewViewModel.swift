// HouseListViewModel.swift
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class HouseListViewModel: ObservableObject {
    @Published var houseListings: [HouseListing] = []

    private var db = Firestore.firestore()

    func fetchHouseListings() {
        db.collection("houseListings").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error fetching house listings: \(error.localizedDescription)")
                return
            }

            if let snapshot = snapshot {
                self.houseListings = snapshot.documents.compactMap { document in
                    do {
                        let houseListing = try document.data(as: HouseListing.self)
                        return houseListing
                    } catch {
                        print("Error decoding house listing: \(error.localizedDescription)")
                        return nil
                    }
                }
            }
        }
    }
}
