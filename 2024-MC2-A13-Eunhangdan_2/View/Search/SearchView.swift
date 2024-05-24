import Foundation
import SwiftUI
import SwiftData

struct SearchView: View {
    @State var searchText: String = ""
    @State var searchActivated: Bool = false
    @Environment (\.modelContext) private var modelContext
    @State private var brickSetList: [BrickSet] = []
    @State private var limitedBrickSetList: [BrickSet] = []
    @State private var minifigsList: [Minifig] = []
    @State private var limitedMinifigsList: [Minifig] = []
    
    var body: some View {
        NavigationStack{
            VStack{
                SeriesView()
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Product Number / Name")
                    .onSubmit(of: .search) {
                        loadData()
                        searchActivated.toggle()
                    }
                    .fullScreenCover(isPresented: $searchActivated) {
                        SearchResultView(brickSetList: $brickSetList, limitedBrickSetList: $limitedBrickSetList, minifigsList: $minifigsList, limitedMinifigsList: $limitedMinifigsList, searchActivated: $searchActivated)
                    }
                
            }
            .navigationTitle("Search")
        }
    }
    
    private func loadData() {
        var bricks: [BrickSet] = []
        var minifigs: [Minifig] = []
        var limitedBricks: [BrickSet] = []
        var limitedMinifigs: [Minifig] = []
        
        let setBrickPredicate = #Predicate<BrickSet> {
            $0.setID.localizedStandardContains(searchText)
            || $0.theme.localizedStandardContains(searchText)
            || $0.subtheme.localizedStandardContains(searchText)
            || $0.setName.localizedStandardContains(searchText)
        }
        
        let setMinifigPredicate = #Predicate<Minifig> {
            $0.minifigName.localizedStandardContains(searchText)
            || $0.themeCategory.localizedStandardContains(searchText)
        }
        
        let brickDescriptor = FetchDescriptor<BrickSet>(predicate: setBrickPredicate)
        let minifigDescriptor = FetchDescriptor<Minifig>(predicate: setMinifigPredicate)
        
        var limitedBrickDescriptor = FetchDescriptor<BrickSet>(predicate: setBrickPredicate)
        limitedBrickDescriptor.fetchLimit = 2
        var limitedMinifigDescriptor = FetchDescriptor<Minifig>(predicate: setMinifigPredicate)
        limitedMinifigDescriptor.fetchLimit = 2
        
        do {
            bricks = try modelContext.fetch(brickDescriptor)
            limitedBricks = try modelContext.fetch(limitedBrickDescriptor)
            minifigs = try modelContext.fetch(minifigDescriptor)
            limitedMinifigs = try modelContext.fetch(limitedMinifigDescriptor)
        } catch {
            print("Failed to fetch data: \(error)")
        }
        
        self.brickSetList = bricks
        self.limitedBrickSetList = limitedBricks
        self.minifigsList = minifigs
        self.limitedMinifigsList = limitedMinifigs
    }
    
    
}

#Preview {
    SearchView()
}
