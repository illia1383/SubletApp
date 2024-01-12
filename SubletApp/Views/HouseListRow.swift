// HouseListRow.swift
import SwiftUI

struct HouseListRow: View {
    var houseListing: HouseListing

    var body: some View {
        VStack(alignment: .leading) {
            Text(houseListing.title)
                .font(.headline)
            Text(houseListing.address)
                .font(.subheadline)
            // Add more details as needed
        }
        .padding()
    }
}

struct HouseListRow_Previews: PreviewProvider {
    static var previews: some View {
        HouseListRow(houseListing: HouseListing(title: "Cozy Cottage", address: "123 Main St", price: 1000, coordinates: HouseListing.Coordinates(latitude: 43.0096, longitude: -81.2737)))
    }
}
