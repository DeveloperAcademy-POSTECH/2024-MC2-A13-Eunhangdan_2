//
//  EunhaengdanVol1App.swift
//  EunhaengdanVol1
//
//  Created by marty.academy on 5/12/24.
//

import SwiftUI
import SwiftData
import Foundation

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

        do { // 아래 3개의 모델을 담을 수 있도록 컨테이너를 설정
            sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration] )
        } catch {
            fatalError("Failed to initialize the model container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(sharedModelContainer)
    }
}
