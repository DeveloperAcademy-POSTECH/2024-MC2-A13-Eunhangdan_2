import Foundation
import SwiftUI
import SwiftData

struct SeriesView: View {
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \BrickSet.theme) var brickSets:[BrickSet]
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("LEGO Series")) {
                    ForEach(series(), id: \.self) { aSeries in
                        NavigationLink(destination: SeriesDetailView(seriesTitle: aSeries)){
                            HStack{
                                Text("\(aSeries)")
                                    .font(.title2)
                                Spacer()
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    func series() -> [String] {
        var sortOfSeries: [String] = []
        for brickSet in brickSets {
            let trimString = brickSet.theme.trimmingCharacters(in: ["\""])
            sortOfSeries.append(trimString)
        }
        sortOfSeries.remove(atOffsets: [0])
        return sortOfSeries.uniqued()
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
