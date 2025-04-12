//
//  MainPage.swift
//  prac
//
//  Created by 나현흠 on 3/29/25.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("먹먹 시간")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("마이 페이지")
                }
        }
    }
    
}


#Preview {
    MainPage()
}
