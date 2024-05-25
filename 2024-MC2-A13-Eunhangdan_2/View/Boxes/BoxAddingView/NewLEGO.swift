import Foundation
import SwiftUI
import SwiftData

struct NewLEGO: View {
    
    
    @State var isAssembled: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State private var date = Date()
    @State private var isSearchSelected: Bool = false
    @State private var isProductSelected: Bool = false
    
    @State var setList: [BrickSetApiModel.Set] = []
    var networkManager = NetworkManager.shared
    @Environment (\.modelContext) private var modelContext
    
    @State var searchText: String = ""
    @State var selectedProductNumber: Int = 0
    
    var body: some View {
        NavigationStack {
            List{
                HStack{
                    Text("LEGO Number")
                    NavigationLink {
                        SearchLEGOBoxForAdding(searchText: $searchText, selectedProductNumber: $selectedProductNumber, isProductSelected: $isProductSelected, setList: $setList)
                            .navigationTitle("LEGO Number Search").navigationBarTitleDisplayMode(.inline)
                    } label: {
                        HStack {
                            Spacer()
                            if !isProductSelected {
                                Text("Search")
                                Image("chevron.forward")
                            } else {
                                Text("\(String(selectedProductNumber))")
                            }
                        }
                        
                    }
                }
                Text("Purchase Date")
                DatePicker(
                    "Purchase Date",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                
                Toggle("Assembled", isOn: $isAssembled)
                
            }
            .navigationTitle("New LEGO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        for set in setList {
                            // 검색 리스트 품목 중 선택한 것과 같은 품목만
                            if set.setID == selectedProductNumber {
                                let bricksSet = BrickSet(setID: String(selectedProductNumber), theme: set.theme, subtheme: set.subtheme ?? "", setName: set.name, pieces: set.pieces ?? 0, isAssembled: isAssembled, price: 0.00,  minifigureIdList: [], setImageURL: set.image.imageURL, isFavorite: false, isOwned: true, photos: [], purchaseDate: date, releasedDate: set.year)
                                
                                createBrickSet(bricksSet)
                            }
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Add")
                    })
                    .disabled(!isProductSelected)
                }
            }
        }
        
    }
    
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

#Preview{
    // Container 설정
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
    
    return NewLEGO()
        .modelContainer(container)
}
