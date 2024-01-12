import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewViewModel()

    
    var body: some View {
        NavigationView{
            VStack {
                
                //Header
                HeaderView()
                Spacer()
                
                //Login Form
                Form{
                    
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }

                    TextField("Email",text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    SecureField("Password",text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    TLButton(title: "Log In", background: .blue){
                        viewModel.login()
                    }
                }
                VStack{
                    Text("Don't have an account?")
                    NavigationLink("Create an account",destination: RegisterView())
                }
            }
        
        }
        .padding(.bottom,50)
        Spacer()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
