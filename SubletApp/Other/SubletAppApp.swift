//
//  SubletAppApp.swift
//  SubletApp
//
//  Created by Illia Lotfalian on 2023-12-22.
//

import SwiftUI
import FirebaseCore


@main
struct SubletAppApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
