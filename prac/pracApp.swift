//
//  pracApp.swift
//  prac
//
//  Created by 나현흠 on 3/29/25.
//

import SwiftUI
import Firebase

@main
struct pracApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainPage()
            } else{
                LoginView()
            }
        }
    }
}
