
import SwiftUI
import MapKit


struct MapAnnotationsView: View {
    var annotation: IdentifiableAnnotation

    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .foregroundColor(.red)
                .font(.title)
            Text(annotation.annotation.title ?? "")
                .fixedSize()
        }
    }
}
