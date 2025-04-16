//
//  LoginView.swift
//  prac
//
//  Created by 나현흠 on 4/15/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State var text: String = ""
    @State var name: String = ""
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
                
                VStack{
                    HStack {
                        Text("닉네임")
                            .font(.body)
                        Spacer()
                        TextField("닉네임을 영어로 입력해주세요", text: $text)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: text) { newValue in
                                let filtered = newValue.lowercased().filter { $0.isLetter && $0.isASCII }
                                if filtered != newValue {
                                    text = filtered
                                }
                            }
                        
                    }
                    Divider()
                    HStack {
                        Text("이름")
                            .font(.body)
                        Spacer()
                        TextField("이름을 입력해주세요", text: $name)
                            .multilineTextAlignment(.trailing)
                        
                    }
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color.gray, lineWidth: 1)
//                    )
//                    .padding(.horizontal, 30)
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 30)
                Button(action: {
                    loginWithUUID(nickname: text, name: name) { success in
                        if success {
                            isLoggedIn = true
                        } else {
                            // 실패 처리
                        }
                    }
                }) {
                    Text("확인")
                        .foregroundColor((text.isEmpty || name.isEmpty) ? .gray : .white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background((text.isEmpty || name.isEmpty) ? Color.gray.opacity(0.3) : Color.blue)
                        .cornerRadius(8)
                }
                .disabled(text.isEmpty || name.isEmpty)
                .padding(.top, 20)
                .padding(.horizontal, 30)
            }
        }
    }
}

func loginWithUUID(nickname: String, name: String, completion: @escaping (Bool) -> Void) {
    Auth.auth().signInAnonymously { result, error in
        if let error = error {
            print("로그인 오류: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        guard let uid = result?.user.uid else {
            completion(false)
            return
        }
        
        // Firestore에 사용자 정보 저장
        let db = Firestore.firestore()
        db.collection("users").document(nickname.lowercased()).setData([
            "uuid": uid,
            "nickname": nickname,
            "name": name,
            "timestamp": Timestamp()
        ]) { error in
            if let error = error {
                print("데이터 저장 오류: \(error.localizedDescription)")
                completion(false)
            } else {
                print("사용자 정보 저장 성공")
                completion(true)
            }
        }
    }
}

#Preview {
    LoginView()
}
