import Foundation
import SwiftUI

@ViewBuilder
func getImage(id: String, url: String) -> some View {
    if UIImage(named: "\(id)") != nil {
        Image("\(id)")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 110)
            .clipped()
    } else {
        //TODO: getting Data and show as Image later
        AsyncImage(url: URL(string: "\(url)")) {image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            // Progress View
        }
        .frame(width: 150, height: 110)
        .clipped()
    }
}
