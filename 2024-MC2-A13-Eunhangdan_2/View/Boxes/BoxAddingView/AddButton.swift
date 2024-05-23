import Foundation
import SwiftUI

struct AddButton: View {
    @State private var isPresented: Bool = false
    @State var searchText: String = ""
    @State var selectedProductNumber: Int = 0
    
    var body: some View {
        Button(action: {
            isPresented = true
        }, label: {
            Text("+")
        })
        .sheet(isPresented: $isPresented, content: {
            NewLEGO()
        })
        
    }
    
}

#Preview {
    AddButton()
}
