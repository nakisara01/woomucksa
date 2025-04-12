//
//  eventCard.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct EventCardView: View {
    var title: String
    var place: String
    var date: String
    var onTap: () -> Void  // 버튼 액션 클로저
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack(alignment: .center, spacing: 20) {
                Text(title)
                    .font(.headline)
                VStack(alignment: .leading) {
                    HStack {
                        Text("📍")
                        Text(place)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    HStack {
                        Text("🕐")
                        Text(date)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle()) // 🔹 버튼 스타일 없애기
    }
}


#Preview {
    HomeView()
}
