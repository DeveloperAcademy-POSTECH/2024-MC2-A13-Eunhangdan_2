//
//  LEGOVillageView.swift
//  Mari
//
//  Created by yoomin on 5/22/24.
//

import SwiftUI
import SwiftData

struct BrickVillageView: View {
    @Environment (\.modelContext) private var modelContext
    @State private var hideNavigationBar = false
    @State private var presentSheet = false
    @Query var minifigs: [Minifig] = []
    @Binding var village: BrickVillege
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
            
            ForEach(village.registeredMinifigureID.indices , id: \.self) { index in
                Button(action: {
                    presentSheet = true
                    selectedMinifigIndex = index
                }) {
                    Image("\(village.registeredMinifigureID[index])")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(
                            village.rotationDegree[index]
                        ))
                    
                }
                .position(CGPoint(x: village.xCoordi[index] ,y: village.yCoordi[index]))
                
            }
        }  // ZStack
        .onAppear {
            for minifig in minifigs {
                print("\(minifig.splitCategory[0])")
            }
            
        }
        .sheet(isPresented: $presentSheet, onDismiss: didDismiss) {
            ScrollView {
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
                ScrollView(.horizontal) {
                    // 타이틀까지 찌그러지~~~~잔아~~~~~ㅁㅊ~~~~~
                    // 뷰를 따로 올려야 할 것 같은 느낌..갱의 코드를 참고하러 떠나자..
                    HStack{
                        ForEach(minifigs, id: \.self) { mf in
                            //MARK: - 미니 피규어 필터링 기준 중요 !!!
                            if mf.themeCategory.contains(village.categoryInfo)
                            {
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
                                
                            }
                        }  // ForEach
                    }
                }  // HStack
                
            }  // VStack
            .presentationDetents([.height(250)])
            //.presentationDragIndicator(.visible)  // grabber
            
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
}



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container : ModelContainer = {
        let schema = Schema([
            BrickSet.self, Minifig.self, BrickVillege.self,
        ])

        do {
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    return BrickVillageView(village: .constant(BrickVillege(backgroundID: UUID(), backgroundName: "village03", categoryInfo: "Town", registeredMinifigureID: ["whoAreYou", "whoAreYou", "whoAreYou"], xCoordi:[100, 300, 200], yCoordi: [200, 500, 700], rotationDegree: [-15, -90, 25])))
        .modelContainer(container)
    
    
}
