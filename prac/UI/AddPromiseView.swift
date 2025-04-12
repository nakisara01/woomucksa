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
                            Text("약속 정보")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            VStack(spacing: 0) {
                                InputRow(label: "장소", hintText: "장소를 입력해주세요")
                                Divider()
                                InputRow(label: "시간", hintText: "0000")
                                Divider()
                                InputRow(label: "세부 내용", hintText: "10자 이내(ex. 간맥, 식사 등)")
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

struct InputRow: View {
    @State var text: String = ""
    var label: String
    var hintText: String
    var valueColor: Color = .black

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
            Spacer()
            TextField(hintText, text: $text)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 8)
    }
}

#Preview{
    MyPageView()
}
