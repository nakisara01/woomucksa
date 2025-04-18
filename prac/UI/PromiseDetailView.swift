//
//  PromiseDetailView.swift
//  prac
//
//  Created by 나현흠 on 4/14/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct PromiseDetailView: View {
    var id: String
    @AppStorage("nickname") var currentNickname: String = ""
    @State private var promise: Promise? //처음에는 값이 없기 때문에 ?를 사용해 현재는 값이 정해지지 않았다는 것을 의미
    @State private var showDeleteAlert = false
    @State private var showJoinAlert = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationStack {
            if let promise = promise { //promise = promise는 promise가 nil인지 아닌지 확인하는 용도
                VStack(spacing: 32) {
                    // 사용자 정보 카드
                    VStack(alignment: .leading, spacing: 12) {
                        Text("약속 정보")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        VStack(spacing: 0) {
                            InfoRow(label: "장소", value: promise.place)
                            Divider()
                            InfoRow(label: "일시", value: promise.date)
                            Divider()
                            InfoRow(label: "세부 내용", value: promise.purpose)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.bottom,20)
                        
                        VStack(spacing: 0) {
                            InfoRow(label: "최소 인원 제한", value: "\(promise.minCount)명")
                            Divider()
                            InfoRow(label: "최대 인원 제한", value: "\(promise.maxCount)명")
                            Divider()
                            InfoRow(label: "현재 참여 인원", value: promise.nickname.joined(separator: ", "))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    // 이메일 문의 버튼
                    if promise.nickname.first == currentNickname {
                        // 약속 생성자일 경우: 삭제하기 버튼
                        Button(action: {
                            showDeleteAlert = true
                        }) {
                            Text("삭제하기")
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .alert(
                            "정말 삭제하시겠어요?",
                            isPresented: $showDeleteAlert,
                            actions: {
                                Button("삭제", role: .destructive) {
                                    deletePromise()
                                }
                                Button("취소", role: .cancel) {}
                            },
                            message: {
                                Text("이 약속은 영구적으로 삭제되며 복구할 수 없습니다.")
                            }
                        )
                    } else if promise.nickname.contains(currentNickname) {
                        // 이미 참여한 경우: 참여완료 비활성화 버튼
                        Button(action: {}) {
                            Text("참여완료")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .disabled(true)
                    } else {
                        // 참여하지 않은 경우: 참여하기 버튼
                        Button(action: {
                            showJoinAlert = true
                        }) {
                            Text("참여하기")
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .alert(
                            "약속에 참여하시겠습니까?",
                            isPresented: $showJoinAlert,
                            actions: {
                                Button("참여") {
                                    joinPromise()
                                }
                                Button("취소", role: .cancel) {}
                            },
                            message: {
                                Text("참여 시 닉네임이 목록에 추가되고, 이후 삭제할 수 없습니다.")
                            }
                        )
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .navigationTitle("\(promise.nickname.first ?? "사용자")님의 약속")
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .background(Color(.systemGray6))
            } else {
                ProgressView("불러오는 중...")
            }
        }
        .onAppear { //onAppear는 SwiftUI에서 뷰가 화면에 나타났을 때 실행되는 코드 블록
            print("불러오려는 문서 ID: \(id)")
            fetchPromiseById()
        }
    }
    
    func fetchPromiseById() {
        print("불러오려는 문서 ID: \(id)")
        let db = Firestore.firestore() //firebase 인스턴스 불러오기
        db.collection("promise").document(id).getDocument { document, error in
            if let error = error {
                print("문서 불러오기 실패: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists, //guard는 조건에 맞지 않으면 함수를 빠르게 종료한다.
                  let data = document.data() else {
                print("문서가 없거나 데이터 없음")
                return
            }

            let purpose = data["purpose"] as? String ?? ""
            let place = data["place"] as? String ?? ""
            let timestamp = data["date"] as? Timestamp
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd(E) HH:mm"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            let date = timestamp != nil ? dateFormatter.string(from: timestamp!.dateValue()) : ""
            let minCount = data["minCount"] as? Int ?? 0
            let maxCount = data["maxCount"] as? Int ?? 0
            let nickname = data["nickname"] as? [String] ?? []

            self.promise = Promise(
                id: document.documentID,
                purpose: purpose,
                place: place,
                date: date,
                minCount: minCount,
                maxCount: maxCount,
                nickname: nickname
            )
        }
    }
    
    func joinPromise() {
        guard let promise = promise else { return }
        let db = Firestore.firestore()
        var updatedNicknames = promise.nickname
        updatedNicknames.append(currentNickname)
        
        db.collection("promise").document(promise.id).updateData(["nickname": updatedNicknames]) { error in
            if let error = error {
                print("참여 실패: \(error.localizedDescription)")
                return
            }
            self.promise?.nickname = updatedNicknames
        }
    }

    func deletePromise() {
        guard let promise = promise else { return }
        let db = Firestore.firestore()
        db.collection("promise").document(promise.id).delete { error in
            if let error = error {
                print("삭제 실패: \(error.localizedDescription)")
                return
            }
            dismiss()
        }
    }
}



struct Promise: Identifiable {
    var id: String
    var purpose: String
    var place: String
    var date: String
    var minCount: Int
    var maxCount: Int
    var nickname: [String]
}
