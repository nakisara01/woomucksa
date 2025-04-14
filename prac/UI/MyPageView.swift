//
//  MyPageView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct MyPageView: View {
    @Environment(\.openURL) var openURL
    private var email = SupportEmail(toAddress: "nakisara01@postech.ac.kr", subject: "[문의사항]", messageHeader: "아래에 내용을 입력해주세요.")
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 32) {
                // 사용자 정보 카드
                VStack(alignment: .leading, spacing: 12) {
                    Text("나의 정보")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack(spacing: 0) {
                        InfoRow(label: "닉네임", value: "Joid")
                        Divider()
                        InfoRow(label: "본명", value: "나현흠")
                        Divider()
                        InfoRow(label: "유저 ID", value: "dbwjid12345678", valueColor: .black)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.white))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                // 이메일 문의 버튼
                Button(action: {
                    email.send(openURL: openURL)
                }) {
                    Text("이메일로 문의하기")
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
            .navigationTitle("마이 페이지")
            .background(Color(.systemGray6))
            .toolbarBackground(Color(.white), for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview{
    MyPageView()
}
