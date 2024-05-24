import Foundation
import SwiftUI
import SwiftData

struct SeriesDetailView: View {
    
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \BrickSet.theme) var brickSets: [BrickSet]
    @Query(sort: \Minifig.splitCategory[0]) var minifigs: [Minifig]
    @State private var filteredBrickList: [BrickSet] = []
    @State private var filteredMinifigList: [Minifig] = []
    
    var seriesName: String = ""
 
    
    var body: some View {
        VStack{
            searchedBrickSets(list: filteredBrickList)
            searchedMinifigure(list: filteredMinifigList)
        }
        .onAppear{
            print("\(seriesName)")
            loadSeriesData(sortOfSeries: seriesName)
        }
    }
    
    private func loadSeriesData(sortOfSeries: String) {
        let setBrickPredicate = #Predicate<BrickSet> {
            $0.theme.localizedStandardContains("\(sortOfSeries)")
        }
        
        let setMinifigPredicate = #Predicate<Minifig> {
            $0.themeCategory.localizedStandardContains("\(sortOfSeries)")
        }
        
        let brickDescriptor = FetchDescriptor<BrickSet>(predicate: setBrickPredicate)
        let minifigDescriptor = FetchDescriptor<Minifig>(predicate: setMinifigPredicate)
        
        do {
            filteredBrickList = try modelContext.fetch(brickDescriptor)
            filteredMinifigList = try modelContext.fetch(minifigDescriptor)
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}
//
//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container : ModelContainer = {
//        let schema = Schema([
//            BrickSet.self, Minifig.self, BrickVillege.self,
//        ])
//
//        do {
//            return try ModelContainer(for: schema, configurations: config)
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//    
//    return SeriesDetailView(_brickSets: [], _minifigs: [], seriesName: "Avator")
//        .modelContainer(container)
//}
