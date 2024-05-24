import Foundation
import SwiftUI
import SwiftData

struct SearchedMinifigureDetailView: View{
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \Minifig.minifigName) var minifigs: [Minifig]
    
    var body: some View {
        ForEach(minifigs, id: \.minifigID) { mini in
            HStack{
                AsyncImage(url: URL(string: "\(mini.minifigImageURL)")) {image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    // 김리의 프로그레스 뷰 넣기
                }
                .frame(width: 150, height: 130)
                .clipped()
                Spacer()
                VStack{
                    Text("\(mini.themeCategory)")
                    Text("")
                    Text("Name: \(mini.minifigName)")
                }
            }
        }
    }
}

#Preview {
    SearchedMinifigureDetailView()
}
