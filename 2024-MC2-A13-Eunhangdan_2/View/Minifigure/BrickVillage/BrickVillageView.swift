//
//  LEGOVillageView.swift
//  Mari
//
//  Created by yoomin on 5/22/24.
//

import SwiftUI

struct BrickVillageView: View {
    @State private var hideNavigationBar = false
    @State var presentSheet = false
    
    @State var img0: String = "whoAreYou"
    @State var img1: String = "whoAreYou"
    @State var img2: String = "whoAreYou"
    
    @State var img_mf: [String] = ["tlm089","tlm107","tlm108","tlm109"]
    
    class Coordinate {
        var x: Double
        var y: Double
        
        init(x: Double = 0.0 , y: Double = 0.0) {
            self.x = x
            self.y = y
        }
    }
    
    @State var coordinates: [Coordinate] = [Coordinate(x: 100, y: 200),
                                            Coordinate(x: 300, y: 500),
                                            Coordinate(x: 200, y: 700)]
    
    var body: some View {
        ZStack {
            Image("village03")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 1) {    // 화면을 탭해서 네비게이션바 hide
                    print("tapped!")
                    self.hideNavigationBar.toggle()
                }
            
            // Btn1
            Button(action: {
                presentSheet = true
            }) {
                Image("\(img0)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-15))
                
            }
            .position(CGPoint(x: coordinates[0].x, y: coordinates[0].y))
            
            // Btn2
            Button(action: {
                presentSheet = true
            }) {
                Image("\(img1)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                
            }
            .position(CGPoint(x: coordinates[1].x, y: coordinates[1].y))
            
            
            // Btn3
            Button(action: {
                presentSheet = true
            }) {
                Image("\(img2)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(25))
                
            }
            .position(CGPoint(x: coordinates[2].x, y: coordinates[2].y))
            
            
        }  // ZStack
        .sheet(isPresented: $presentSheet, onDismiss: didDismiss) {
            VStack {
                Spacer(minLength: 16)
                // sheet_title
                HStack {
                    Text("Select Minifigures")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Button(action: {
                        presentSheet.toggle()
                    }){
                        ZStack {
                            Rectangle()
                                .frame(width: 30, height: 30)
                                .cornerRadius(1000)
                                .foregroundStyle(.tertiary)
                            
                            Image(systemName: "multiply")
                                .foregroundStyle(.secondary)
                                .bold()
                        }
                        
                    }
                    
                }
                .padding(16)
                // 피규어 캐러셀 -> 중앙에 오는 피규어 클릭해서 선택
                HStack {
                    // 타이틀까지 찌그러지~~~~잔아~~~~~ㅁㅊ~~~~~
                    // 뷰를 따로 올려야 할 것 같은 느낌..갱의 코드를 참고하러 떠나자..
                    ForEach(img_mf, id: \.self) { mf in
                        Button(action: {
                            
                            img0 = mf
                            
                            presentSheet = false
                        }){
                            Image(mf)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 200)
                        }
                        
                    }  // ForEach
                    
                }  // HStack
                
            }  // VStack
            .presentationDetents([.height(250)])
            //.presentationDragIndicator(.visible)  // grabber
            
        } // sheet
        
        .navigationBarHidden(hideNavigationBar)
        .navigationBarTitle("Hogwarts Moment Class", displayMode: .inline)
        .edgesIgnoringSafeArea([.top, .bottom])
        .toolbar(.hidden, for: .tabBar)
        
    } //body
    
    func didDismiss() {
        // Handle the dismissing action.
    }
    
    
}  // BrickVillageView



#Preview {
    BrickVillageView()
}
