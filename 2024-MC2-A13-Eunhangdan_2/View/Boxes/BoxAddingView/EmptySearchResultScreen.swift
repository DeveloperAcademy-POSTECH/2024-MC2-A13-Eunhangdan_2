import Foundation
import SwiftUI

struct EmptySearchResultScreen: View {
    var body: some View {
        VStack {
            Group {
                Text("No such item with the input")
            }
            .font(.title)
            .fontWeight(.bold)
            Text("")
            
            Group {
                Text("Registration needs a minifigure's correct ID.")
                Text("Please re-confirm and try with the correct one.")
            }
            .font(.caption)
            
        }
    }
}
