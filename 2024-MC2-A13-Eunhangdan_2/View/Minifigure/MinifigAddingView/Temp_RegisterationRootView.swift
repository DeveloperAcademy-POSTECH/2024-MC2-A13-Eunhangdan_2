//
//  Temp_RegisterationRootView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by marty.academy on 5/22/24.
//

import SwiftUI
import SwiftData

struct Temp_RegisterationRootView: View {
    @State var isPresented : Bool = false
    @Query(sort: \Minifig.minifigID, order: .reverse) var minifigs: [Minifig]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button ("ADD") {
            isPresented.toggle()
        }.sheet(isPresented : $isPresented) {
            NavigationStack {
                RegisterMinifigureView()
            }
        }
        
        List {
            ForEach (minifigs) { minifig in
                VStack {
                    Text("Name: \(minifig.minifigName)")
                    Text("ID: \(minifig.minifigID)")
                }
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

    return Temp_RegisterationRootView().modelContainer(container)
}
