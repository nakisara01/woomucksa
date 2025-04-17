//
//  AddPromiseView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI
import Firebase

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
    @State var place: String = ""
    @State private var wakeUp = Date()
    @State var purpose: String = ""
    @State private var minCount: Int = 0
    @State private var maxCount: Int = 0
    @AppStorage("nickname") var nickname: String = ""
    
    var isFormValid: Bool {
        return !place.isEmpty &&
               !purpose.isEmpty &&
               minCount <= maxCount
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                // 사용자 정보 카드
                VStack(alignment: .leading, spacing: 12) {
                    Text("약속 정보")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack(spacing: 0) {
                        InputRow(text: $place, label: "장소", hintText: "식당을 입력해주세요")
                        Divider()
                        
                        HStack {
                            Text("일시")
                                .font(.body)
                            Spacer()
                            DatePicker("날짜를 선택해주세요", selection: $wakeUp, displayedComponents: [.date, .hourAndMinute])
                                .labelsHidden()
                                .environment(\.locale, Locale(identifier: "ko_KR"))
                        }
                        .padding(.vertical, 8)
                        Divider()
                        
                        InputRow(text: $purpose, label: "세부 내용", hintText: "10자 이내(ex. 간맥, 식사 등)")
                        Divider()
                        
                        PickerRow(label: "최소인원", selection: $minCount, range: 1...10)
                        Divider()
                        PickerRow(label: "최대인원", selection: $maxCount, range: minCount...20)
                        // TODO: 최대인원이 최소인원보다 작게 입력되지 않도록 변경
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: {
                    createPromise(nickname: nickname, place: place, date: wakeUp, purpose: purpose, minCount: minCount, maxCount: maxCount, completion: {
                        success in
                        if success {
                            dismiss()
                        } else {
                            print("약속 생성 실패")
                        }
                    })
                }) {
                    Text("약속 만들기")
                        .foregroundColor(isFormValid ? .white : .gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(!isFormValid)
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Joid님의 약속 생성중")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("뒤로가기") {
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

func createPromise(nickname: String, place: String, date: Date, purpose: String, minCount: Int, maxCount: Int, completion: @escaping (Bool) -> Void) {
    let db = Firestore.firestore()
    
    let promiseData: [String: Any] = [
        "nickname": nickname.lowercased(),
        "place": place,
        "date": Timestamp(date: date),
        "purpose": purpose,
        "minCount": minCount,
        "maxCount": maxCount,
        "createdAt": Timestamp()
    ]
    
    db.collection("promise").addDocument(data: promiseData) { error in
        if let error = error {
            print("약속 생성 오류: \(error.localizedDescription)")
            completion(false)
        } else {
            print("약속 생성 성공")
            completion(true)
        }
    }
}

#Preview {
    AddPromiseView()
}
