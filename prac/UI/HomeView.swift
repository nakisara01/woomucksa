//
//  HomeView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { suceess, error in
            if let error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
}

struct HomeView: View {
    @State var showSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    @State private var myPromises: [Promise] = []
    @State private var otherPromises: [Promise] = []
    /*
     State가 부여되는 변수의 경우 그 상태를 SwiftUI가 계속해서 추적해야하는데
     body 안에 있으면 view의 lifecycle 안에 관리할 수 없어서 밖에 둬야함.
     값이 body 외부에 있어야 값이 변경될 때 뷰를 자동으로 다시 렌더링 한다.
     */
    struct Promise: Identifiable {
        var id: String
        var purpose: String
        var place: String
        var date: String
        var nickname: [String]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Text("내가 참여한 이벤트")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    if myPromises.isEmpty {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 80)
                            .overlay(
                                Text("지금은 약속이 없습니다")
                                    .foregroundColor(.gray)
                            )
                    }

                    ForEach(myPromises) { promise in
                        NavigationLink(destination: PromiseDetailView(id: promise.id)) {
                            EventCardView(
                                title: promise.purpose,
                                place: promise.place,
                                date: promise.date
                            )
                        }
                    }
                    
                    Text("진행중인 이벤트")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    if otherPromises.isEmpty {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 80)
                            .overlay(
                                Text("지금은 약속이 없습니다")
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    ForEach(otherPromises) { promise in
                        NavigationLink(destination: PromiseDetailView(id: promise.id)) {
                            EventCardView(
                                title: promise.purpose,
                                place: promise.place,
                                date: promise.date
                            )
                        }
                    }
                }
                .padding()
            }
            .onAppear{
                fetchPromises()
            }
            .navigationTitle("우리 먹먹한 사이...")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("약속 추가") {
                        showSheet.toggle()
                    }
                    .foregroundColor(.blue) // 버튼 글자 색
                    .sheet(isPresented: $showSheet) {
                        AddPromiseView(onDismiss: fetchPromises)
                    }
                }
            }
            .toolbarBackground(Color(.white), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color(.systemGray6))
        }
    }
    
    func fetchPromises(){
        myPromises = []
        otherPromises = []
        
        let db = Firestore.firestore()
        db.collection("promise").getDocuments { snapshot, error in
            if let error = error {
                print("에러 발생: \(error)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("문서 없음")
                return
            }

            for doc in documents {
                let data = doc.data()
                let purpose = data["purpose"] as? String ?? ""
                let place = data["place"] as? String ?? ""
                let timestamp = data["date"] as? Timestamp
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd(E) HH:mm"
                dateFormatter.locale = Locale(identifier: "ko_KR")
                let date = timestamp != nil ? dateFormatter.string(from: timestamp!.dateValue()) : ""
                let nickname = data["nickname"] as? [String] ?? []
                let id = doc.documentID
                let promise = Promise(id: id, purpose: purpose, place: place, date: date, nickname: nickname)
                print(promise)
                let currentNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
                
                if nickname.contains(currentNickname) {
                    myPromises.append(promise)
                } else {
                    otherPromises.append(promise)
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
