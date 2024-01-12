import SwiftUI

struct CustomButton: View {
    let title: String
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Log In", background: .blue) {
            // Action
        }
    }
}
