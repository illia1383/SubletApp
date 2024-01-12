import SwiftUI

struct AddHouseButton: View {
    @Binding var isPopoverPresented: Bool

    var body: some View {
        Button(action: {
            
            isPopoverPresented.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
        }
        .popover(isPresented: $isPopoverPresented, arrowEdge: .trailing) {
            // Add your popover content for entering house information
            AddHousePopoverView()
        }
    }
}
