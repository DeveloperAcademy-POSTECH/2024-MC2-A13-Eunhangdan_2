
//
//  SwiftDataTestView.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/17/24.
//

import SwiftData
import SwiftUI

struct SwiftDataMinifigView: View {
    
    // 워드에서 저장을 눌렀을 때 최종 저장되는 곳 = container
    // 워드 작업을 하는 창(되돌리기 등) = context
    @Environment (\.modelContext) private var modelContext
    // @Query 어노테이션을 이용해서 container에 데이터를 불러올 수 있음 (get only)
    @Query(sort: \Minifig.createdDate, order: .reverse) var minifigs : [Minifig]
    
    var body: some View {
        NavigationSplitView {
            HStack{
                Text("Minifig 리스트 of \(minifigs.count)")
                    .font(.largeTitle)
                Spacer()
   
            }.padding(.horizontal, 16)
            
            List {
                ForEach(minifigs, id: \.minifigID) { minifig in
                    VStack{
                        HStack{
                            Text("구매 시간 : ")
                            Text("\(minifig.createdDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            Spacer()
                        }
                        .padding(8)
                        
                        HStack{
                            Text("미니피규어 이름 : \(minifig.minifigName)")
                            Spacer()
                        }
                        .padding(8)
                        
                        
                        HStack{
                            Text("category : \(minifig.themeCategory)")
                            Spacer()
                        }
                        .padding(8)
                        HStack{
                            Text("splitted[0] : \(minifig.splitCategory[0])")
                            Text("splitted[1] : \(minifig.splitCategory[1])")
                            Spacer()
                        }
                        .padding(8)
                        
                        HStack{
                            if !minifig.includedSetID.isEmpty {
                                let convertedString = minifig.includedSetID.reduce("", { x, y in  
                                   x + ","  + y})
                                
                                Text("포함된 세트 : \(convertedString) ")
                                Spacer()
                            }
                        }
                        .padding(8)
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }

            .listStyle(.plain)
            
            Spacer()
        } detail: {
            Text("Minifigs")
        }
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
    
    // 임시 데이터 추가
    for i in 1..<5 {
        
        let minifig = Minifig(minifigID: String(i + 10), minifigName: "", themeCategory: "", includedSetID: [], price: 0.0, minifigCount: 0)
        container.mainContext.insert(minifig)
    }
    
    return SwiftDataTestView()
        .modelContainer(container)
}
