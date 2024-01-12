import SwiftUI
import MapKit


struct SearchAnnotation: Identifiable {
    let id = UUID()
    var annotation: MKPointAnnotation
    // You can add more properties specific to the search result here
}


struct SearchAnnotationView: View {
    var annotation: SearchAnnotation
    var onTap: () -> Void

    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.blue)
                .font(.title)
                .onTapGesture(perform: onTap)
            Text(annotation.annotation.title ?? "")
                .fixedSize()
        }
    }
}
