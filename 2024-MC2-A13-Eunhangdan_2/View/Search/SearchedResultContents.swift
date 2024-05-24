import SwiftUI

@ViewBuilder
func searchedBrickSets(list: [BrickSet]) -> some View {
    ForEach(list, id: \.setID) { set in
        NavigationLink {
            BoxDetailView(brickSetID: set.setID)
        } label: {
            HStack{
                getImage(id: set.setID, url: set.setImageURL)
                Spacer()
                VStack(alignment: .leading){
                    if !set.subtheme.isEmpty {
                        Text("\(set.subtheme) ").bold()
                    } else {
                        Text("\(set.theme) ").bold()
                    }
                    Text("\nReleased year: \(String(set.releasedDate))")
                }
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .frame(height: 110)
                Spacer()
            }
        }.padding()
            .tint(.black)
        Divider()
    }
}

@ViewBuilder
func searchedMinifigure(list: [Minifig]) -> some View {
    ForEach(list, id: \.minifigID) { mini in
        NavigationLink {
            // Minifigure details
            MinifigureInfoView(minifigureID: mini.minifigID)
        } label: {
            HStack {
                getImage(id: mini.minifigID, url: mini.minifigImageURL)
                Spacer()
                VStack(alignment: .leading){
                    Text("\(mini.themeCategory)\n").bold()
                    Text("\(mini.minifigName)")
                }
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .frame(height: 110)
                Spacer()
            }
        }.padding()
            .tint(.black)
        Divider()
    }
    
}

