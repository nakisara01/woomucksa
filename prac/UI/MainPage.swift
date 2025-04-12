//
//  MainPage.swift
//  prac
//
//  Created by 나현흠 on 3/29/25.
//

import SwiftUI

struct MainPage: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white  // ✅ 탭바 배경색
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemBlue  // ✅ 선택된 아이템 색
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

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
