import Foundation
import SwiftUI
import SwiftData

struct SeriesView: View {
    //    @State var sortOfSeries: [String] = []
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \BrickSet.theme) var brickSets: [BrickSet]
    @State private var brickList: [BrickSet] = []
    @State private var miniList: [Minifig] = []
    
    var body: some View {
        List {
            Section(header: Text("LEGO Series")) {
                ForEach(series(), id: \.self) { aSeries in
                    //series 해결하기..
                    NavigationLink(destination:
                                    SeriesDetailView(brickList: $brickList, miniList: $miniList).navigationTitle(aSeries)){
                        HStack{
                            Text("\(aSeries)")
                                .font(.title2)
                            Spacer()
                        }
                        
                    }.onAppear{loadSeriesData(sortOfSeries: aSeries)}
                }
            }
        }
    }
    
    
    func series() -> [String] {
        var sortOfSeries: [String] = []
        for brickSet in brickSets {
            sortOfSeries.append(brickSet.theme)
        }
        sortOfSeries.remove(atOffsets: [0])
        return sortOfSeries.uniqued()
    }
    
    private func loadSeriesData(sortOfSeries: String) {
        var bricks: [BrickSet] = []
        var minifigs: [Minifig] = []
        
        let setBrickPredicate = #Predicate<BrickSet> {
            $0.theme.localizedStandardContains("\(sortOfSeries)")
        }
        
        let setMinifigPredicate = #Predicate<Minifig> {
            $0.themeCategory.localizedStandardContains("\(sortOfSeries)")
        }
        
        let brickDescriptor = FetchDescriptor<BrickSet>(predicate: setBrickPredicate)
        let minifigDescriptor = FetchDescriptor<Minifig>(predicate: setMinifigPredicate)
        
        do {
            bricks = try modelContext.fetch(brickDescriptor)
            minifigs = try modelContext.fetch(minifigDescriptor)
        } catch {
            print("Failed to fetch data: \(error)")
        }
        
        self.brickList = bricks
        self.miniList = minifigs
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

#Preview {
    SeriesView()
}
