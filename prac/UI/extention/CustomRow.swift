//
//  CustomRow.swift
//  prac
//
//  Created by 나현흠 on 4/13/25.
//

import SwiftUI

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
        .padding(.vertical, 16)
    }
}

struct PickerRow: View {
    var label: String
    @State private var selectedNumber = 0
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .font(.body)
                Spacer()
                // 눌렀을 때 Picker 펼쳐지도록
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text("\(selectedNumber)")
                        .foregroundColor(isExpanded ? .blue : .black)
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white)
                        )
                }
            }

            if isExpanded {
                Picker("", selection: $selectedNumber) {
                    ForEach(0..<100) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .frame(height: 150)
                .clipped()
                .transition(.move(edge: .bottom)) // 부드러운 아래쪽 등장
            }
        }
        .padding(.vertical, 8)
    }
}

