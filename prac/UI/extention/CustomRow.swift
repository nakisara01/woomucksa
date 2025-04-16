//
//  CustomRow.swift
//  prac
//
//  Created by 나현흠 on 4/13/25.
//

import SwiftUI

struct InputRow: View {
    @Binding var text: String
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
    @Binding var selection: Int
    var range: ClosedRange<Int>
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .font(.body)
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text("\(selection)")
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
                Picker("", selection: $selection) {
                    ForEach(Array(range), id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .frame(height: 150)
                .clipped()
                .transition(.move(edge: .bottom))
            }
        }
        .padding(.vertical, 8)
    }
}

struct InfoRow: View {
    var label: String
    var value: String
    var valueColor: Color = .black

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
            Spacer()
            Text(value)
                .foregroundColor(Color.gray)
        }
        .padding(.vertical, 8)
    }
}
