//
//  EunhaengdanVol1App.swift
//  EunhaengdanVol1
//
//  Created by marty.academy on 5/12/24.
//

import SwiftUI
import SwiftData

@main
struct EunhaengdanVol1App: App {
    let sharedModelContainer : ModelContainer
    
    // @Environment (\.modelContext) private var modelContext
    // @Query 어노테이션을 이용해서 container에 데이터를 불러올 수 있음 (get only)
    // @Query(sort: \BrickSet.setID, order: .reverse) var brickSets: [BrickSet]

    init() {
        // 모델 컨테이너 설정
        let schema = Schema([
            BrickSet.self, Minifig.self, BrickVillege.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
        do { // 아래 3개의 모델을 담을 수 있도록 컨테이너를 설정
            sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration] )
        } catch {
            fatalError("Failed to initialize the model container")
        }
        
        // 데이터가 없다면 요청
        if isFirstLaunch() {
            print("first")
            let context = sharedModelContainer.mainContext
            let brickSets = loadBrickSetCSVData()
            let minifigs = loadMinifigCSVData()
            
            do{
                for brickSet in brickSets {
                    context.insert(brickSet)
                }
                
                for minifig in minifigs {
                    context.insert(minifig)
                    // 미니 피규어 마다 등록된 세트 순회
                    for includedSetID in minifig.includedSetID{
                        let setPredicate = #Predicate<BrickSet> {
                            $0.setID == includedSetID
                        }
                        
                        let descriptor = FetchDescriptor<BrickSet>(predicate: setPredicate)
                        let brickSets = try context.fetch(descriptor)
                        // 탐색 완료 후 brickSet 리스트를 순회하며 속성 추가
                        for brickSet in brickSets {
                            brickSet.minifigureIdList.append(minifig.minifigID)
                            context.insert(brickSet)
                        }
                        
                    }
                }
                
                try context.save()
            } catch {
                print("Error: Failed to save CSV Data to SwiftData")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TotalTestView()
        }
        .modelContainer(sharedModelContainer)
    }
}
