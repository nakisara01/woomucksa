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
        VStack(alignment: .leading) {
            HStack{
                VStack(alignment: .leading){
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(Color.black)
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
                    .padding(.top, 5)
                }
                .frame(maxWidth: 600, alignment: .leading)
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
}


#Preview {
    HomeView()
}
