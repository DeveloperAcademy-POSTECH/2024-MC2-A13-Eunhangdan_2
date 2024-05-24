//
//  TotalTestView.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/21/24.
//

import SwiftUI
import SwiftData

struct TotalTestView: View {
    var body: some View {
        NavigationStack{
            
            List {
                NavigationLink {
                    NetworkTestView()
                } label: {
                    Text("NetworkTestView")
                }

                NavigationLink {
                    SwiftDataTestView()
                } label: {
                    Text("SwiftDataTestView")
                }
                
                NavigationLink {
                    SwiftDataMinifigView()
                } label: {
                    Text("SwiftDataMinifigView")
                }
                
                NavigationLink {
                    HandleCSVTestView(brickSets: loadBrickSetCSVData(), minifigs: loadMinifigCSVData())
                } label: {
                    Text("HandleCSVTestView")
                }

                
            }
            .navigationTitle("종합 테스트 화면")
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
    
    return TotalTestView()
        .modelContainer(container)
    
}
