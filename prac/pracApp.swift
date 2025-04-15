//
//  pracApp.swift
//  prac
//
//  Created by 나현흠 on 3/29/25.
//

import SwiftUI

@main
struct pracApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
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
