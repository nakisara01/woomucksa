//
//  AddPromiseView.swift
//  prac
//
//  Created by 나현흠 on 4/12/25.
//

import SwiftUI

struct AddPromiseView: View{
    @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                Color.white
                
                
                Button {
                //뷰 계층 구조에서 정의된 환경 변수에 접근하기 .dissmiss() 호출
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.blue)
                        .font(.headline)
                        .padding(10)
                        .background(Color.white.cornerRadius(10))
                        .padding(20)
                }
                VStack{
                    
                }
            }
        }
}
