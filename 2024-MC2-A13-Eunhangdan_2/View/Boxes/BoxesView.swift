
//
//  BoxesView.swift
//  Mari
//
//  Created by yoomin on 5/20/24.
//

import SwiftUI
import SwiftData

struct BoxesContainerView : View {
    
    @State private var sortOrder = SortDescriptor(\BrickSet.purchaseDate)
    @State var filterOption: FilterType = .none
    
    @State var boxAddViewPresented = false
    @State var minifigAddViewPresented = false
    
    @State var firstSortOption = "checkmark"
    @State var secondSortOption = ""
    @State var thirdSortOption = ""
    @State var recentSortOption = ""
    
    
    var body: some View {
        NavigationStack {
            BoxesView(sort: sortOrder, filter: filterOption)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Menu {
                            Button {
                                self.sortOrder = SortDescriptor(\BrickSet.purchaseDate)
                                self.filterOption = .none
                                self.firstSortOption = "checkmark"
                                self.secondSortOption = ""
                                self.thirdSortOption = ""
                                self.recentSortOption = ""
                            } label: {
                                Label("All LEGO", systemImage: "\(firstSortOption)")
                            }
                            
                            Button {
                                self.sortOrder = SortDescriptor(\BrickSet.purchaseDate, order: .reverse)
                                self.filterOption = .none
                                self.firstSortOption = ""
                                self.secondSortOption = ""
                                self.thirdSortOption = ""
                                self.recentSortOption = "checkmark"
                            } label: {
                                Label("Recent", systemImage: "\(recentSortOption)")
                            }
                            
                            Button {
                                self.filterOption = .assembled
                                self.firstSortOption = ""
                                self.secondSortOption = "checkmark"
                                self.thirdSortOption = ""
                                self.recentSortOption = ""
                            } label: {
                                Label("Assembled", systemImage: "\(secondSortOption)")
                            }
                            
                            Button(action: {
                                self.filterOption = .favorite
                                self.firstSortOption = ""
                                self.secondSortOption = ""
                                self.thirdSortOption = "checkmark"
                                self.recentSortOption = ""
                            }) {
                                Label("My Favorite", systemImage: "\(thirdSortOption)")
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {
                                boxAddViewPresented = true
                            }) {
                                Text("Add LEGO")
                                Image("shippingboxplus")
                            }
                            Button(action: {
                                minifigAddViewPresented = true
                            }) {
                                Text("Add Minifigures")
                                Image("batteryblockplus")
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        
        .sheet(isPresented: $boxAddViewPresented) {
            NewLEGO()
        }.sheet(isPresented: $minifigAddViewPresented) {
            NavigationStack {
                RegisterMinifigureView()
            }
        }
    }
}


struct BoxesView: View {
    
    @Environment (\.modelContext) private var modelContext
    // @Query 어노테이션을 이용해서 container에 데이터를 불러올 수 있음 (get only)
    @Query var brickSets: [BrickSet]
    
    init(sort: SortDescriptor<BrickSet>, filter: FilterType) {
        if filter == .favorite {
            
            _brickSets = Query(filter: #Predicate {
                $0.isFavorite == true
            }, sort: [sort])
        }
        else if filter == .assembled {
            _brickSets = Query(filter: #Predicate {
                $0.isAssembled == true
            }, sort: [sort])
        }
        else {
            _brickSets = Query(sort: [sort])
        }
    }
    
    var imgStrings: [String] {
        brickSets.map { $0.setID }
    }

    var body: some View {
        NavigationStack {
            VStack {
                BoxesGrid(imgStrings: imgStrings, spacing: 3)
            }
            .navigationTitle("Boxes")
            .navigationBarTitleDisplayMode(.automatic)
            
        }
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
    
    
    
    return BoxesView(sort: SortDescriptor(\BrickSet.setID), filter: .none).modelContainer(container)
}

