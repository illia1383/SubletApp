import SwiftUI

struct AddHousePopoverView: View {
    // Your popover content for entering house information
    var body: some View {
        VStack {
            Text("Enter House Information")
                .font(.title)
                .padding()

            // Add your form elements here

            Spacer()

            Button("Add House") {
                // Handle adding the house to your data source
            }
            .padding()
        }
        .padding()
    }
}
