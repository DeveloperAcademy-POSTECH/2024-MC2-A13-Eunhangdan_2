
//
//  SwiftDataTestView.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/17/24.
//

import SwiftData
import SwiftUI


struct SwiftDataTestView: View {
    
    // 워드에서 저장을 눌렀을 때 최종 저장되는 곳 = container
    // 워드 작업을 하는 창(되돌리기 등) = context
    @Environment (\.modelContext) private var modelContext
    // @Query 어노테이션을 이용해서 container에 데이터를 불러올 수 있음 (get only)
    @Query(sort: \BrickSet.setID, order: .reverse) var brickSets: [BrickSet]

    
    
    var body: some View {
        NavigationSplitView {
            HStack{
                Text("박스 리스트")
                    .font(.largeTitle)
                Spacer()
   
                
            }.padding(.horizontal, 16)
            
            List {
                ForEach(brickSets, id: \.setID) { set in
                    VStack{
                        HStack{
                            Text("구매 시간 : ")
                            Text("\(set.purchaseDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            Spacer()
                        }
                        .padding(8)
                        
                        HStack{
                            Text("세트 이름 : \(set.setName)")
                            Spacer()
                        }
                        .padding(8)
                        
                        HStack{
                            if !set.minifigureIdList.isEmpty {
                                Text("포함된 미니피규어 : \(set.minifigureIdList[0] )")
                                Spacer()
                            }
                        }
                        .padding(8)
                    }
                }
                .onDelete(perform: deleteBrickSet)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        
                        let set = BrickSet(setID: String(Int.random(in: 1...210000000)), theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0)
                        createBrickSet(set)
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }

            .listStyle(.plain)
            
            
            
            Spacer()
        } detail: {
            Text("BrickSets")
        }
    }
    
    // 대충 만든 삭제 메서드
    private func deleteBrickSet(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                do {
                    modelContext.delete(brickSets[index])
                    try modelContext.save()
                } catch {
                    print("test delete error")
                }
            }
        }
    }
    
    // 대충 만든 추가 메서드
    private func createBrickSet(_ brickSet: BrickSet) {
        withAnimation {
            do {
                modelContext.insert(brickSet)
                try modelContext.save()
            } catch {
                print("test save error")
            }
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
        let brickSet = BrickSet(setID: String(i + 10), theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0)
        container.mainContext.insert(brickSet)
    }
    
    return SwiftDataTestView()
        .modelContainer(container)
}
