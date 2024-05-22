//
//  BoxDetailView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI
import SwiftData

struct BoxDetailView: View {
    
    @Environment (\.modelContext) private var modelContext
    let brickSetID: String
    @State private var brick: BrickSet = BrickSet(setID: "error", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0, setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0)
        
    var body: some View {
        VStack{
            ScrollView{
                BoxDetailTextView(brickSet: brick)
                BoxDetailMyMemoryView(brickSet: brick)
            }
        }
        .onAppear(perform: loadBrick)

    }
    
    // ID에 해당하는 BrickSet 호출하기
    private func loadBrick() {
        var bricks: [BrickSet] = []
        
        let setPredicate = #Predicate<BrickSet> {
            $0.setID == brickSetID
        }
        
        let descriptor = FetchDescriptor<BrickSet>(predicate: setPredicate)

        do {
            bricks = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch brick sets: \(error)")
        }
        
        if !bricks.isEmpty {
            self.brick = bricks[0]
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
    
    
    container.mainContext.insert(BrickSet(setID: "avt010", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "avt007", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "avt008", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "avt011", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "bio001", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "bio002", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    
    container.mainContext.insert(BrickSet(setID: "bio005", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
    

    return BoxDetailView(brickSetID: "bio001")
        .modelContainer(container)
}
