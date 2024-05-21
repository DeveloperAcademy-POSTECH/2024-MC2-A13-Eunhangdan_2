import Foundation
import SwiftUI

struct SeriesView: View {
    let series: [String] = ["Starwars", "Dune", "Inside Out", "Minions", "Batman", "Dungeons & Dragons"]
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("LEGO Series")) {
                    ForEach(series, id: \.self) { aSeries in
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
}

#Preview {
    SeriesView()
}
