import Foundation
import SwiftUI

struct SeriesDetailView: View {
    @Binding var brickList: [BrickSet]
    @Binding var miniList: [Minifig]
    
    var body: some View {
        searchedBrickSets(list: brickList)
        searchedMinifigure(list: miniList)
    }
}

#Preview {
    SeriesDetailView(brickList: .constant([]), miniList: .constant([]))
}
