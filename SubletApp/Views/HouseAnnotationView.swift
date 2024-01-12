import SwiftUI
import MapKit

struct HouseAnnotation: Identifiable {
    let id = UUID()
    var annotation: MKPointAnnotation
    // You can add more properties specific to the house here
}

struct HouseAnnotationView: View {
    var annotation: HouseAnnotation
    var onTap: () -> Void

    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .foregroundColor(.red)
                .font(.title)
                .onTapGesture(perform: onTap)
            Text(annotation.annotation.title ?? "")
                .fixedSize()
        }
    }
}
