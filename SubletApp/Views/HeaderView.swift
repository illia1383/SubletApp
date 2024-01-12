//
//  HeaderView.swift
//  SubletApp
//
//  Created by Illia Lotfalian on 2023-12-30.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack{
            Image("houseLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300) // Adjust size as needed
                .offset(y: -25)

            Text("SubletSwift")
                .font(.title)
                .bold()
                .padding()
                .offset(y:-150)
        }
    }
}

#Preview {
    HeaderView()
}
