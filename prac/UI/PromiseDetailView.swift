//
//  PromiseDetailView.swift
//  prac
//
//  Created by 나현흠 on 4/14/25.
//

import SwiftUI

struct PromiseDetailView: View {

        var body: some View {
            @Environment(\.dismiss) var dismiss
            
            NavigationStack {
                VStack(spacing: 32) {
                    // 사용자 정보 카드
                    VStack(alignment: .leading, spacing: 12) {
                        Text("약속 정보")
                            .font(.caption)
                            .foregroundColor(.gray)

                        VStack(spacing: 0) {
                            InfoRow(label: "장소", value: "어리닭갈비")
                            Divider()
                            InfoRow(label: "일시", value: "2025.03.26")
                            Divider()
                            InfoRow(label: "세부 내용", value: "친목 도모")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.bottom,20)
                        
                        VStack(spacing: 0) {
                            InfoRow(label: "최소 인원 제한", value: "3명")
                            Divider()
                            InfoRow(label: "최대 인원 제한", value: "4명")
                            Divider()
                            InfoRow(label: "현재 참여 인원", value: "Joid")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    // 이메일 문의 버튼
                    Button(action: {
                        // 이메일 전송 액션
                    }) {
                        Text("참여하기")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.top)
                .navigationTitle("Joid님의 약속")
                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button("뒤로가기") {
//                            dismiss()
//                        }
//                        .foregroundColor(.blue)
//                    }
                }
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .background(Color(.systemGray6))
            }
        }
}

#Preview {
    PromiseDetailView()
}
