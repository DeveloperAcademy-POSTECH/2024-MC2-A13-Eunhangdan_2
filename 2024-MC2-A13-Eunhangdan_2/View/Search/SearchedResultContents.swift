import SwiftUI

func trimString(sentence: String) -> String {
    var trimString = sentence.trimmingCharacters(in: ["\""])
    trimString = trimString.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimString
}

@ViewBuilder
func searchedBrickSets(list: [BrickSet]) -> some View {
    ForEach(list, id: \.setID) { set in
        HStack{
        NavigationLink {
            BoxDetailView(brickSetID: set.setID)
        } label: {
                AsyncImage(url: URL(string: "\(set.setImageURL)")) {image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    // 김리의 프로그레스 뷰 넣기
                }
                .frame(width: 150, height: 120)
                .clipped()
                .border(.black)
            }
            Spacer()
            
            HStack{
                VStack{
                    Text("\(trimString(sentence: set.theme)) - \(trimString(sentence: set.subtheme))\n")
                    Text("Released Date: \(String(set.releasedDate))")
                }
                Spacer()
            }.border(.black)
            
        }.padding()
    }
}

@ViewBuilder
func searchedMinifigure(list: [Minifig]) -> some View {
    ForEach(list, id: \.minifigID) { mini in
        HStack {
        NavigationLink {
//            MinifigureModalView()
        } label: {
            
            AsyncImage(url: URL(string: "\(mini.minifigImageURL)")) {image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                // 김리의 프로그레스 뷰 넣기
            }
            .frame(width: 150, height: 110)
            .clipped()
            .border(.black)
        }
            Spacer()
            
            HStack{
                VStack{
                    Text("\(trimString(sentence: mini.themeCategory))\n")
                    Text("Name: \(trimString(sentence: mini.minifigName))")
                }
                Spacer()
            }.border(.black)
        }.padding()
    }
    
}
