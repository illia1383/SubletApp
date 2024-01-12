import SwiftUI

struct AnnotationPopupView: View {
    var annotation: IdentifiableAnnotation
    var onClose: () -> Void  // Closure to handle the close action

    var body: some View {
        VStack {
            Text(annotation.annotation.title ?? "Unknown")
            if let price = annotation.price {
                Text("Price/month: \(price)")
                    .font(.subheadline)
                if let phoneNumber = annotation.phoneNumber{
                    Text("Contact Info:\(phoneNumber)")
                        .font(.subheadline)
                }
            }
            Button(action: onClose) {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.gray)
                    .imageScale(.large)
            }
        }
        .frame(width:300, height: 200)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
