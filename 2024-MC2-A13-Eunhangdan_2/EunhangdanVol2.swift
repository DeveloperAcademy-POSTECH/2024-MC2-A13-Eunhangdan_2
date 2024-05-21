//
//  _024_MC2_A13_Eunhangdan_2App.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by marty.academy on 5/21/24.
//

import SwiftUI
import SwiftData

@main
struct EunhangdanVol2: App {
    let sharedModelContainer : ModelContainer
    
    init() {
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
    }
    
    var body: some Scene {
        WindowGroup {
            TotalTestView()
        }
        .modelContainer(sharedModelContainer)
    }
}
