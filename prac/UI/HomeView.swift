//
//  HomeView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct HomeView: View {
    @State var showSheet: Bool = false
    /*
     State가 부여되는 변수의 경우 그 상태를 SwiftUI가 계속해서 추적해야하는데
     body 안에 있으면 view의 lifecycle 안에 관리할 수 없어서 밖에 둬야함.
     값이 body 외부에 있어야 값이 변경될 때 뷰를 자동으로 다시 렌더링 한다.
     */
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("내가 참여한 이벤트")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    EventCardView(
                        title: "Joid님의 약속",
                        place: "야끼니꾸소량 포항쌍사점",
                        date: "2025.03.27(목) 19:30",
                        onTap: { print("작동됨") }
                    )
                    
                    Text("진행중인 이벤트")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    EventCardView(
                        title: "Rama님의 약속",
                        place: "라멘베라보",
                        date: "2025.03.27(목) 19:30",
                        onTap: { print("작동됨") }
                    )
                }
                .padding()
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
                        AddPromiseView()
                    }
                }
            }
            .toolbarBackground(Color(.white), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color(.systemGray6))
        }
    }
}


#Preview {
    HomeView()
}
