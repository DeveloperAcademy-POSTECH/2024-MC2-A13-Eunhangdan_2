import Foundation
import SwiftUI

struct SearchView: View {
    @State var suggestions = ["2480", "starwars", "dune", "minion", "batman", "dungeons&dragons"]
    @State var searchText: String = ""
    
    var filteredSuggestions: [String] {
        guard !searchText.isEmpty else {return []}
        return suggestions.sorted().filter{ $0.localizedStandardContains(searchText)}
    }
    
    var body: some View {
        NavigationStack{
            series
                .navigationTitle("Search")
        }
    }
    
    var series: some View {
        VStack{
            SeriesView()
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "품번/시리즈명", suggestions: {
                    ForEach(filteredSuggestions, id: \.self) { suggestion in
                        NavigationLink {
                            SearchResultView(searchText: suggestion)
                        } label: {
                            Text(suggestion).searchCompletion(suggestion)
                        }
                    }
                })
        }
    }
}

#Preview {
    SearchView()
}
