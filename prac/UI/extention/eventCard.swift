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
    
    var body: some View {
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
}


#Preview {
    HomeView()
}
