import Foundation
import SwiftUI
import SwiftData

struct MinifigureDetailView: View {
    @Environment (\.modelContext) private var modelContext
//    @State var minifigureID: String = ""
//    @Binding var id: String
    let mini: Minifig
    @State private var filteredMinifigureList: [Minifig] = []
    @Query(sort: \Minifig.minifigName) var minifigInfo: [Minifig]

    var body: some View {
            VStack {
                if UIImage(named: "\(mini.minifigID)") != nil {
                    Image("\(mini.minifigID)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .clipped()
                } else {
                    //TODO: getting Data and show as Image later
                    AsyncImage(url: URL(string: "\(mini.minifigImageURL)")) {image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        // Progress View
                    }
                    .frame(width: 300, height: 300)
                    .clipped()
                }
                HStack {
                    Text("\(mini.themeCategory)")
                        .font(.title.weight(.semibold))
                    Spacer()
                }.multilineTextAlignment(.leading)
                Text("").frame(height: 30)
                HStack {
                    Text("Name: ")
                        .foregroundColor(.gray)
                    Text("\(mini.minifigName)")
                        .font(.subheadline)
                    Spacer()
                }.multilineTextAlignment(.leading)
                Text("")
                HStack {
                    Text("Released year: ")
                        .foregroundColor(.gray)
                    Text("\(mini.minifigID)")
                        .font(.subheadline)
                    Spacer()
                }.multilineTextAlignment(.leading)

//                Divider()
//                HStack {
//                    Text("Series")
//                        .font(.title.weight(.semibold))
//                    Spacer()
//                }
            }.onAppear{loadMinifigureData(id: mini.minifigID)}
            .padding()
    }
    
    private func loadMinifigureData(id: String) {
        let minifigurePredicate = #Predicate<Minifig> {
            $0.minifigID == id
        }
        
        let minifigureDescriptor = FetchDescriptor<Minifig>(predicate: minifigurePredicate)
        
        do {
            filteredMinifigureList = try modelContext.fetch(minifigureDescriptor)
        } catch {
            print("Failed to fetch data: \(error)")
        }
        
    }

}

