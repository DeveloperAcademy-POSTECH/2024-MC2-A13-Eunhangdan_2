import Foundation
import SwiftUI
import SwiftData

struct SearchedLEGODetailView: View{
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \BrickSet.setName) var brickSets: [BrickSet]
    
    var body: some View {
        ForEach(brickSets, id: \.setID) { set in
            HStack{
                AsyncImage(url: URL(string: "\(set.setImageURL)")) {image in
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
                    Text("\(set.theme) - \(set.subtheme)")
                    Text("")
                    Text("Released Date: \(set.releasedDate)")
                }
            }
        }
    }

}

#Preview {
    SearchedLEGODetailView()
}
