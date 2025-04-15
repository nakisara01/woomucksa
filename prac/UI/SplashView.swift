//
//  SplashView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            LoginView() // 2초 후 이동할 메인 페이지
        } else {
            VStack {
                Spacer()
                Image("LaunchImage") // Assets에 있는 이미지
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200) // 원하는 사이즈로 조절
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white) // 배경색
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
