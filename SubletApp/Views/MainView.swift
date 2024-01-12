// MainView.swift
// SubletApp
//
// Created by Illia Lotfalian on 2023-12-24.

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                MapView()
            } else {
                NavigationLink(destination: LoginView()) {
                    Text("Go to Login") // You can use a button or any other view here
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
