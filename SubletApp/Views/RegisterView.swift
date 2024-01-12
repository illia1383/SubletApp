//
//  RegisterView.swift
//  SubletApp
//
//  Created by Illia Lotfalian on 2023-12-30.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()

    
    var body: some View {
        VStack{
            HeaderView()
            Spacer()
            Form{
                TextField("Full Name", text:$viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                TextField("Email address", text:$viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("password", text:$viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                TLButton(title: "Register", background: .blue){
                    viewModel.register()
                }
                .padding()
            }

            

            
        }
    }
}

#Preview {
    RegisterView()
}
