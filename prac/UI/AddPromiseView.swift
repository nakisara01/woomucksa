//
//  AddPromiseView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct AddPromiseView: View{
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                Color.white
                
                
                Button {
                //뷰 계층 구조에서 정의된 환경 변수에 접근하기 .dissmiss() 호출
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.blue)
                        .font(.headline)
                        .padding(10)
                        .background(Color.white.cornerRadius(10))
                        .padding(20)
                }
                NavigationStack{
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
                            // 이메일 전송 액션 (mailto: 등)
                        }) {
                            Text("약속 만들기")
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
                    .navigationTitle("Joid님의 약속 생성중")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("뒤로 가기") {
                                dismiss()
                            }
                            .foregroundColor(.blue) // 버튼 글자 색
                        }
                    }
                    .toolbarBackground(Color(.white), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .background(Color(.systemGray6))
                }
            }
        }
}
