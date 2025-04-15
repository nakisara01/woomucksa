//
//  LoginView.swift
//  prac
//
//  Created by 나현흠 on 4/15/25.
//

import SwiftUI

struct LoginView: View {
    @State var text: String = ""
    var valueColor: Color = .black
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Image("LaunchImage")
                    .resizable()
                    .frame(width:220, height:200)
                
                Text("우리 먹먹한 사이...")
                    .font(.custom("Gamja Flower", size: 32))
                    .padding(.bottom, 130)
                
                HStack {
                    Text("닉네임")
                        .font(.body)
                    Spacer()
                    TextField("닉네임을 입력해주세요", text: $text)
                        .multilineTextAlignment(.trailing)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 30)
                Button("확인") {
                    isLoggedIn = true
                }
                .padding(.top,20)
            }
        }
    }
}

#Preview {
    LoginView()
}
