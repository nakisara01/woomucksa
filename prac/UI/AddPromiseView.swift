//
//  AddPromiseView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct AddPromiseView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white
            RowView()
        }
    }
}


/* 모달 닫기가 제대로 작동되지 않은 이유
 이전의 RowView는 private func, 즉 함수의 형태임
 함수에서는 state, environment 등의 프로퍼티 래퍼의 상태나 환경을 추적하지 못함.
 고로 이를 View 형태로 변경하면서 이러한 문제가 해결됨.
 */

struct RowView: View {
    @Environment(\.dismiss) var dismiss
    @State private var wakeUp = Date()

    var body: some View {
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

                        HStack {
                            Text("일시")
                                .font(.body)
                            Spacer()
                            DatePicker("Please enter a date", selection: $wakeUp)
                                .labelsHidden()
                        }
                        .padding(.vertical, 8)
                        Divider()

                        InputRow(label: "세부 내용", hintText: "10자 이내(ex. 간맥, 식사 등)")
                        Divider()

                        PickerRow(label: "최소인원")
                        Divider()
                        PickerRow(label: "최대인원")
                        // TODO: 최대인원이 최소인원보다 작게 입력되지 않도록 변경
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
                    Text("약속 만들기")
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
            .navigationTitle("Joid님의 약속 생성중")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("뒤로 가기") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    AddPromiseView()
}
