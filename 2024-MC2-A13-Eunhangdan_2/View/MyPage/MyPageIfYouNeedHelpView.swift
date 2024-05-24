//
//  MyPageIfYouNeedHelpView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by kyunglimkim on 5/23/24.
//

import SwiftUI

struct MyPageIfYouNeedHelpView: View {
    var body: some View {
        Image(systemName: "phone.bubble")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(.green)
        Text("김경림 전화번호: 010 3299 2435")
            .font(.title3)
            .foregroundColor(.brown)
            .bold()
        Text("여기로 전화하세요!")
            .font(.headline)
            .foregroundColor(.brown)
    }
}

#Preview {
    MyPageIfYouNeedHelpView()
}
