import SwiftUI

struct CustomAnnotationView: View {
    var annotation: IdentifiableAnnotation
    var onTap: () -> Void

    var body: some View {
        VStack {
            // Your custom view content
            Image(systemName: "mappin")
                .bold()
                .foregroundColor(.red)
                .font(.title)
                .onTapGesture(perform: onTap)
            Text(annotation.annotation.title ?? "")
                .fixedSize()
        }
    }
}


