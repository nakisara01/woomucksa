//
//  HomeView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct HomeView: View {
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
                        // 액션
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


#Preview {
    HomeView()
}
