//
//  LoginViewViewModel.swift
//  SubletApp
//
//  Created by Illia Lotfalian on 2023-12-30.
//
import FirebaseAuth
import Foundation
class LoginViewViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    
    init(){}
    
    func login(){
        guard validate() else{
            return
        }
        //Try log in
        Auth.auth().signIn(withEmail: email, password: password)
        
    }
    private func validate() -> Bool{
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            
            
            errorMessage = "Please fill in all fields"
            
            return false
        }
        
        guard email.contains("@") && email.contains(".")else{
            errorMessage = "Please enter a valid email"
            return false
        }
        return true
    }
}
