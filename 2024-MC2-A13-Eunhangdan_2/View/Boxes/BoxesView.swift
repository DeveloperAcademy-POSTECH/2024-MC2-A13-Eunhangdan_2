
//
//  BoxesView.swift
//  Mari
//
//  Created by yoomin on 5/20/24.
//

import SwiftUI
import SwiftData

struct BoxesView: View {
    
    @Environment (\.modelContext) private var modelContext
    // @Query 어노테이션을 이용해서 container에 데이터를 불러올 수 있음 (get only)
    @Query(sort: \BrickSet.setID) var brickSets: [BrickSet]

    var imgStrings: [String] {
        brickSets.map { $0.setID }
    }

    var body: some View {
        NavigationStack {
            VStack {
                BoxesGrid(imgStrings: imgStrings, spacing: 5)
            }
            .navigationTitle("Boxes")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                        }) {
                            Label("All LEGO", systemImage: "checkmark")
                        }
                        Button(action: {
                        }) {
                            
                            Label("Assembled", systemImage: "")
                 
                        }
                        Button(action: {
                        }) {
                            Label("My Favorite", systemImage: "")
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }  // 필터 메뉴
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                        }) {
                            Text("Add LEGO")
                            Image("shippingboxplus")
                        }
                        Button(action: {
                        }) {
                            Text("Add Minifigures")
                            Image("batteryblockplus")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }  // 레고등록/미니피규어 등록 -> Collection 추가화면으로 이동
                
            }  // toolbar
        }  // NavigationStack
    }
} // BoxesView


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
    
    
    container.mainContext.insert(BrickSet(setID: "avt010", theme: "asdfa", subtheme: "", setName: "fofo", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "avt007", theme: "ff3f", subtheme: "", setName: "fefe", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "avt008", theme: "ff", subtheme: "", setName: "frrf", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "avt011", theme: "", subtheme: "", setName: "gfgf", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "bio001", theme: "", subtheme: "", setName: "qwqw", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "bio002", theme: "", subtheme: "", setName: "vfvf", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "bio005", theme: "", subtheme: "", setName: "vsvs", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    
    
    return BoxesView().modelContainer(container)
}

