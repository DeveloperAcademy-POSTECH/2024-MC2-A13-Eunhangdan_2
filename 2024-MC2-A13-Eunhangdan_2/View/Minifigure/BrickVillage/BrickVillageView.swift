//
//  LEGOVillageView.swift
//  Mari
//
//  Created by yoomin on 5/22/24.
//

import SwiftUI
import SwiftData

struct BrickVillageView: View {
//    
//    
//    typealias BrickVillege = ModelSchemaV1.BrickVillege
    
    @Environment (\.modelContext) private var modelContext
    @State private var hideNavigationBar = false
    @State var presentSheet = false
    @State var minifigs: [Minifig] = []
    
    // 갱과 연동 후
    @State private var village: BrickVillege = BrickVillege(backgroundID: UUID(), backgroundName: "village03", categoryInfo: "StarWars", minifigureHoleCoordinate: [
        Coordinate(x: 100, y: 200, rotationDegree: -15),
        Coordinate(x: 300, y: 500, rotationDegree: -90),
        Coordinate(x: 200, y: 700, rotationDegree: 25)
    ], registeredMinifigureID: ["whoAreYou", "whoAreYou", "whoAreYou"])
    
    @State private var selectedMinifigIndex: Int = 0
    
    
    var body: some View {
        ZStack {
            Image("\(village.backgroundName)")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 1) {    // 화면을 탭해서 네비게이션바 hide
                    print("tapped!")
                    self.hideNavigationBar.toggle()
                }
            
            
            ForEach(village.minifigureHoleCoordinate.indices , id: \.self) { index in
                Button(action: {
                    presentSheet = true
                    selectedMinifigIndex = index
                }) {
                    Image("\(village.registeredMinifigureID[index])")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(Double(village.minifigureHoleCoordinate[index].rotationDegree)))
                    
                }
                .position(CGPoint(x: village.minifigureHoleCoordinate[index].x ,y: village.minifigureHoleCoordinate[index].y))
                
            }
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
                    ForEach(minifigs, id: \.self) { mf in
                        Button(action: {
                            presentSheet = false
                            // 선택 시, village.registeredMinifigure에 정보를 넣어야함
                            village.registeredMinifigureID[selectedMinifigIndex] = mf.minifigID
                        }, label: {
                            Image(mf.minifigID)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 200)
                        })
                        
                        
                    }  // ForEach
                    
                }  // HStack
                
            }  // VStack
            .presentationDetents([.height(250)])
            //.presentationDragIndicator(.visible)  // grabber
            
        } // sheet
        .onAppear{
            loadMinifgs()
        }
        .navigationBarHidden(hideNavigationBar)
        .navigationBarTitle("Hogwarts Moment Class", displayMode: .inline)
        .edgesIgnoringSafeArea([.top, .bottom])
        .toolbar(.hidden, for: .tabBar)
        .onDisappear {
            do {
                modelContext.insert(village)
                try modelContext.save()
            }catch {
                print("Error: failed to save village")
            }
        }
        
        
    } //body
    
    func didDismiss() {
        // Handle the dismissing action.
    }
    
    func loadMinifgs() {
        do {
            let setPredicate = #Predicate<Minifig> {
                // $0.splitCategory[0] == village.categoryInfo
                $0.price == 0
            }

            let descriptor = FetchDescriptor<Minifig>(predicate: setPredicate)
            minifigs = try modelContext.fetch(descriptor)
        } catch {
            print("Error: failed to load Minifigs in VillageView")
        }
    }
}  // BrickVillageView



#Preview {
    BrickVillageView()
}
