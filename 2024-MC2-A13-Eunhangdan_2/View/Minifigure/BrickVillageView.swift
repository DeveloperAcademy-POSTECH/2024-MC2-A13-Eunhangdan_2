//
//  BrickVillageView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by yoomin on 5/23/24.
//

import SwiftUI

struct BrickVillageView: View {
    @State var presentSheet = false
    
    @State var image0: String = "whoAreYou"
    @State var image1: String = "tlm089"
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경이미지
                Image("village01")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                // 버튼1 // 3개 정도 배치
                Button(action: {
                    presentSheet = true
                }) {
                    Image("\(image0)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    
                }.position(x: 200, y: 300)
                
            }
            .navigationTitle("Hogwarts Moment Class")
            .navigationBarTitleDisplayMode(.inline)
            
        } // NavigationStack
        .sheet(isPresented: $presentSheet) {
            VStack {
                Text("SelectMinifigures")
                    .font(.title3)
                    .bold()
                    .position(x: 80, y: 40)
                    .padding(.leading, 16)
                
                // 피규어 캐러셀 -> 중앙에 오는 피규어 클릭해서 선택
                HStack {
                    Button(action: {
                        image0 = image1
                        presentSheet = false
                    }) {
                        Image("\(image1)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 200)
                    }
                }
            }
            .presentationDetents([.height(250)])
            .presentationDragIndicator(.visible)
        } // sheet
        
    }
}

#Preview {
    BrickVillageView()
}
